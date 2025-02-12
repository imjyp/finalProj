package kr.or.ddit.menuSG.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.menuSG.mapper.MenuMapper;
import kr.or.ddit.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MenuServiceImpl implements MenuService {
    
    @Autowired
    private MenuMapper menuMapper;
    
    @Override
    public List<MenuVO> getMenuList(String keyword, String category, int page) {
        return menuMapper.selectMenuList(keyword, category, page);
    }
    
    @Override
    public MenuVO selectMenu(int menuNo) {
        return menuMapper.selectMenu(menuNo);
    }
    
    @Override
    public void updateMenu(MenuVO menuVO) {
        menuMapper.updateMenu(menuVO);
    }
    
    @Override
    public int insertMenu(MenuVO menuVO) {
        // 카테고리 유효성 검사
        if (menuVO.getCtgryNo() < 2 || menuVO.getCtgryNo() > 4) {
            throw new IllegalArgumentException("유효하지 않은 카테고리입니다.");
        }
        menuVO.setMenuDel(1);  // 게시 상태로 설정
        
		return menuMapper.insertMenu(menuVO);
    }
    
    @Override
    public int deleteMenu(int menuNo) {
        try {
            return menuMapper.deleteMenu(menuNo);
        } catch (Exception e) {
            log.error("메뉴 삭제 중 오류 발생", e);
            throw e;
        }
    }
    
    @Override
    public int deleteMenuList(List<Integer> menuNos) {
        try {
            return menuMapper.deleteMenuList(menuNos);
        } catch (Exception e) {
            log.error("메뉴 일괄 삭제 중 오류 발생", e);
            throw e;
        }
    }
    
    @Override
    public int getTotalPages(String keyword, String category) {
        int totalCount = menuMapper.getTotalCount(keyword, category);
        return (int) Math.ceil((double) totalCount / 10);
    }
    
    @Override
    public void updateMenuFileGroup(int menuNo, long fileGroupNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("menuNo", menuNo);
        params.put("fileGroupNo", fileGroupNo);
        menuMapper.updateMenuFileGroup(params);
    }
    
    @Override
    public MenuVO getMenuWithImage(Long fileNo) {
        try {
            MenuVO menu = menuMapper.selectMenuWithImage(fileNo);
            if (menu == null) {
                log.warn("파일 번호 {}에 해당하는 메뉴를 찾을 수 없음", fileNo);
                return null;
            }
            return menu;
        } catch (Exception e) {
            log.error("메뉴 이미지 조회 중 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("메뉴 이미지 조회 실패", e);
        }
    }

    //메뉴 목록에서 모달창의 이미지 삭제 띄움(ex : menuNo 66)
	@Override
	public int deleteImage(String menuNo) {
		return this.menuMapper.deleteImage(menuNo);
	}
}