package kr.or.ddit.menuSG.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.MenuVO;

@Mapper
public interface MenuMapper {
    List<MenuVO> selectMenuList(@Param("keyword") String keyword, 
                               @Param("category") String category, 
                               @Param("page") int page);
    MenuVO selectMenu(int menuNo);
    void updateMenu(MenuVO menuVO);
    int insertMenu(MenuVO menuVO);
    int deleteMenu(int menuNo);
    int deleteMenuList(List<Integer> menuNos);
    void updateMenuFileGroup(Map<String, Object> params);
    int getTotalCount(@Param("keyword") String keyword, 
                     @Param("category") String category);
    MenuVO selectMenuWithImage(Long fileNo);
    //메뉴 목록에서 모달창의 이미지 삭제 띄움(ex : menuNo 66)
	int deleteImage(String menuNo);
}