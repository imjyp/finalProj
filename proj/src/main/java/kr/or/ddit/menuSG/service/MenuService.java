package kr.or.ddit.menuSG.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.MenuVO;

@Service
public interface MenuService {
    List<MenuVO> getMenuList(String keyword, String category, int page);
    MenuVO selectMenu(int menuNo);
    void updateMenu(MenuVO menuVO);
    int insertMenu(MenuVO menuVO);
    int deleteMenu(int menuNo);
    int deleteMenuList(List<Integer> menuNos);
    void updateMenuFileGroup(int menuNo, long fileGroupNo);
    int getTotalPages(String keyword, String category);
    MenuVO getMenuWithImage(Long fileNo);
    //메뉴 목록에서 모달창의 이미지 삭제 띄움(ex : menuNo 66)
	int deleteImage(String menuNo);
}
