package kr.or.ddit.item.jy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.item.jy.mapper.ItemMapper;
import kr.or.ddit.item.jy.service.ItemService;
import kr.or.ddit.vo.ItemVO;

@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	ItemMapper itemMapper;
	
	// 품목 리스트
	@Override
	public List<ItemVO> list(Map<String, Object> map) {
		return this.itemMapper.list(map);
	}

	// 전체 행 개수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.itemMapper.getTotal(map);
	}

	//jsp에서 사용할 List<ItemVO> selectedItems
	@Override
	public List<ItemVO> selectedItems(List<Integer> items) {
		return this.itemMapper.selectedItems(items);
	}
	
}
