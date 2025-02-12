package kr.or.ddit.findingstore.jc.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.findingstore.jc.mapper.findStoreMapper;
import kr.or.ddit.vo.StoreVO;

@Service
public class findStoreServiceImpl implements ifindStoreService{
	
	@Autowired
	findStoreMapper mapper;

	@Override
	public List<StoreVO> map(Map<String, Object> map) {
		return this.mapper.map(map);
	}
	
	

}
