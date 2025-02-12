package kr.or.ddit.menuSG.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.net.URLEncoder;
import java.nio.file.Path;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.util.FileCopyUtils;

import kr.or.ddit.menuSG.service.MenuService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/menu")
public class MenuController {
    
    @Autowired
    private MenuService menuService;
    
    @Autowired
    private UploadController uploadController;
    
    @GetMapping("/manage")
    public String getMenuList(Model model, 
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(defaultValue = "1") int page) {
        
        log.info("keyword: {}, category: {}, page: {}", keyword, category, page);
        
        List<MenuVO> menuList = menuService.getMenuList(keyword, category, page);
        int totalPages = menuService.getTotalPages(keyword, category);
        
        model.addAttribute("menuList", menuList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        
        return "menu";
    }
    
    //메뉴 목록에서 모달창 띄움(ex : menuNo 64)
    @GetMapping("/detail/{menuNo}")
    @ResponseBody
    public ResponseEntity<MenuVO> getMenuDetail(@PathVariable int menuNo) {
        try {
            MenuVO menu = menuService.selectMenu(menuNo);
            
            // 상세 디버깅 로그 추가
            log.info("Menu Detail - menuNo: {}", menu.getMenuNo());
            log.info("FileGroup Info - fileGroupNo: {}", menu.getFileGroupNo());
            
            if (menu.getFileDetailList() != null) {
                menu.getFileDetailList().forEach(file -> {
                    log.info("FileDetail - fileNo: {}, originalName: {}, saveName: {}, saveLocate: {}",
                        file.getFileNo(),
                        file.getFileOriginalName(),
                        file.getFileSaveName(),
                        file.getFileSaveLocate()
                    );
                });
            }
            
            return new ResponseEntity<MenuVO>(menu, HttpStatus.OK);
        } catch (Exception e) {
            log.error("메뉴 상세 조회 중 오류 발생", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    //메뉴 목록에서 모달창의 이미지 삭제 띄움(ex : menuNo 66)
    @ResponseBody
    @PostMapping("/deleteImage")
    public int deleteImage(String menuNo) {
    	log.info("deleteImage->menuNo : "+menuNo);
    	
    	int result = this.menuService.deleteImage(menuNo);
    	log.info("deleteImage->result : "+result);
    	
    	return result;
    }
    
    @GetMapping("/edit/{menuNo}")
    public String editMenuForm(@PathVariable int menuNo, Model model) {
        model.addAttribute("menu", menuService.selectMenu(menuNo));
        return "menu/edit";
    }
    
    @PostMapping("/edit/{menuNo}")
    public String editMenu(@PathVariable int menuNo, MenuVO menuVO) {
        menuService.updateMenu(menuVO);
        return "redirect:/menu/manage";
    }
    
    @GetMapping("/new")
    public String newMenuForm() {
        return "menu/new";
    }
    
    @PostMapping("/new")
    public String createMenu(MenuVO menuVO) {
        menuService.updateMenu(menuVO);
        return "redirect:/menu/manage";
    }
    
    @PostMapping("/delete/{menuNo}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteMenu(@PathVariable int menuNo) {
        Map<String, String> response = new HashMap<>();
        try {
            int result = menuService.deleteMenu(menuNo);
            if(result > 0) {
                response.put("status", "success");
                return new ResponseEntity<>(response, HttpStatus.OK);
            } else {
                response.put("status", "fail");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            }
        } catch(Exception e) {
            log.error("메뉴 삭제 중 오류 발생", e);
            response.put("status", "error");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/deleteMenus")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteMenuList(@RequestBody List<Integer> menuNos) {
        Map<String, String> response = new HashMap<>();
        try {
            int result = menuService.deleteMenuList(menuNos);
            if(result > 0) {
                response.put("status", "success");
                return new ResponseEntity<>(response, HttpStatus.OK);
            } else {
                response.put("status", "fail");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            }
        } catch(Exception e) {
            log.error("메뉴 일괄 삭제 중 오류 발생", e);
            response.put("status", "error");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateMenu(@RequestBody MenuVO menuVO) {
        log.info("메뉴 수정 요청 - menuVO: {}", menuVO);
        try {
            if (menuVO.getMenuNo() == 0) {
                return new ResponseEntity<>("메뉴 번호가 없습니다.", HttpStatus.BAD_REQUEST);
            }
            if (menuVO.getCtgryNo() < 2 || menuVO.getCtgryNo() > 4) {
                return new ResponseEntity<>("유효하지 않은 카테고리입니다.", HttpStatus.BAD_REQUEST);
            }
            menuService.updateMenu(menuVO);
            return new ResponseEntity<>("success", HttpStatus.OK);
        } catch (Exception e) {
            log.error("메뉴 수정 중 오류 발생", e);
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<String> insertMenu(@ModelAttribute MenuVO menuVO) {
    	log.info("menuvo:::::"+menuVO);
    	
        try {
            // 1. 파일 업로드 처리
        	if (menuVO.getUploadFiles() != null && menuVO.getUploadFiles().length > 0) {
        	    long fileGroupNo = uploadController.multiImageUpload(menuVO.getUploadFiles());
        	    menuVO.setFileGroupNo(fileGroupNo);
        	}
            // 2. 메뉴 정보 저장
            int result = menuService.insertMenu(menuVO);
            log.info("인서트됐엉?"+result);
            
            return new ResponseEntity<>("success", HttpStatus.OK);
        } catch (Exception e) {
            log.error("메뉴 등록 중 오류 발생", e);
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/updateWithImage")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateMenuWithImage(
            @ModelAttribute MenuVO menuVO) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 1. 파일 업로드 처리
            if (menuVO.getUploadFiles() != null && menuVO.getUploadFiles().length > 0) {
                long fileGroupNo = uploadController.multiImageUpload(menuVO.getUploadFiles());
                menuVO.setFileGroupNo(fileGroupNo);
                
                // 파일 그룹 번호 업데이트
                menuService.updateMenuFileGroup(menuVO.getMenuNo(), fileGroupNo);
            }
            
            // 2. 메뉴 정보 업데이트
            menuService.updateMenu(menuVO);
            
            response.put("status", "success");
            return new ResponseEntity<>(response, HttpStatus.OK);
            
        } catch (Exception e) {
            log.error("파일 업로드 중 오류 발생", e);
            response.put("status", "error");
            response.put("message", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @GetMapping("/image/{fileNo}")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@PathVariable Long fileNo) {
        try {
            MenuVO menu = menuService.getMenuWithImage(fileNo);
            if (menu != null && menu.getFileDetailList() != null && !menu.getFileDetailList().isEmpty()) {
                FileDetailVO fileDetail = menu.getFileDetailList().get(0);
                
                // 실제 파일이 저장된 경로 구성
                String uploadFolder = "D:\\upload";
                String filePath = uploadFolder + fileDetail.getFileSaveLocate() + "\\" + fileDetail.getFileSaveName();
                
                File file = new File(filePath);
                
                if (!file.exists()) {
                    log.error("파일을 찾을 수 없습니다: {}", filePath);
                    return new ResponseEntity<>(HttpStatus.NOT_FOUND);
                }
                
                String contentType = Files.probeContentType(file.toPath());
                byte[] imageData = Files.readAllBytes(file.toPath());
                
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.parseMediaType(contentType));
                headers.setCacheControl(CacheControl.maxAge(1, TimeUnit.HOURS));
                headers.setContentLength(imageData.length);
                
                return new ResponseEntity<>(imageData, headers, HttpStatus.OK);
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            log.error("이미지 조회 중 오류 발생: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    // 이미지 파일 체크 메소드 추가
    private boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            return contentType != null && contentType.startsWith("image");
        } catch (IOException e) {
            log.error("파일 타입 체크 중 오류 발생: {}", e.getMessage());
            return false;
        }
    }
    
    @GetMapping("/download/{fileNo}")
    public ResponseEntity<Resource> download(@PathVariable int fileNo) throws Exception {
        try {
            MenuVO menu = menuService.getMenuWithImage((long)fileNo);
            if (menu == null || menu.getFileDetailList() == null || menu.getFileDetailList().isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            FileDetailVO fileDetail = menu.getFileDetailList().get(0);
            String filePath = fileDetail.getFileSaveLocate();
            
            // 실제 파일 경로 구성 (D: 제거)
            Path path = Paths.get("/upload/2025/01/17" + filePath);
            Resource resource = new FileSystemResource(path.toFile());

            if (!resource.exists()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, 
                "attachment; filename=\"" + URLEncoder.encode(fileDetail.getFileOriginalName(), "UTF-8") + "\"");
            headers.add(HttpHeaders.CONTENT_TYPE, fileDetail.getFileMime());

            return new ResponseEntity<>(resource, headers, HttpStatus.OK);
        } catch (Exception e) {
            log.error("파일 다운로드 중 오류 발생", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @GetMapping("/display")
    public ResponseEntity<byte[]> display(@RequestParam String fileName) {
        try {
            String uploadPath = "D:\\upload"; // 실제 업로드 경로
            File file = new File(uploadPath + fileName);
            
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", Files.probeContentType(file.toPath()));
            
            return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
        } catch (IOException e) {
            log.error("이미지 로딩 실패: {}", e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}