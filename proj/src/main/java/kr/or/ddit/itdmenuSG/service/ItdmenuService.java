package kr.or.ddit.itdmenuSG.service;

import java.util.List;

import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.FileGroupVO;
import kr.or.ddit.vo.MenuVO;

public interface ItdmenuService {
    List<MenuVO> getMenuList();

	FileDetailVO file(long filegroupno);
}