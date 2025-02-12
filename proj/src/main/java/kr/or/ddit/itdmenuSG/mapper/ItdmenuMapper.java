package kr.or.ddit.itdmenuSG.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.FileGroupVO;
import kr.or.ddit.vo.MenuVO;

@Mapper
public interface ItdmenuMapper {
    List<MenuVO> selectMenuList();
    List<MenuVO> selectMenuByCategory(int ctgryNo);
    FileDetailVO file(long filegroupno);
}