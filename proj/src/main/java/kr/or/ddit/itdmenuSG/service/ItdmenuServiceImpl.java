package kr.or.ddit.itdmenuSG.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.itdmenuSG.mapper.ItdmenuMapper;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.FileGroupVO;
import kr.or.ddit.vo.MenuVO;

@Service
public class ItdmenuServiceImpl implements ItdmenuService {

    @Autowired
    private ItdmenuMapper menuMapper;

    @Override
    public List<MenuVO> getMenuList() {
        return menuMapper.selectMenuList();
    }

	@Override
	public FileDetailVO file(long filegroupno) {
		return menuMapper.file(filegroupno);
	}
}