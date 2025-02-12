package kr.or.ddit.member.jy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.member.jy.mapper.StoreEmpMapper;
import kr.or.ddit.member.jy.service.StoreEmpService;
import kr.or.ddit.vo.StoreEmpVO;

@Service
public class StoreEmpServiceImpl implements StoreEmpService {

	@Autowired
	StoreEmpMapper storeEmpMapper;
	
	@Override
	public List<StoreEmpVO> listAll() {
		return this.storeEmpMapper.listAll();
	}

}
