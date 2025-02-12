package kr.or.ddit.itemSG.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.itemSG.mapper.ItemMapperSG;
import kr.or.ddit.vo.ItemVO;

@Service("sgItemServiceImpl")
public class ItemServiceImpl implements ItemService {

	@Autowired
	ItemMapperSG itemMapper;
	
	// 품목 리스트
	@Override
	public List<ItemVO> itemList(Map<String, Object> map) {
		return this.itemMapper.itemList(map);
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
	
	// 추가 필요한 메서드 구현
	@Override
	public ItemVO detail(int itemNo) {
		return this.itemMapper.detail(itemNo);
	}
	
	@Override
	public int insert(ItemVO itemVO) {
		return this.itemMapper.insert(itemVO);
	}
	
	@Override
	public int update(ItemVO itemVO) {
		return this.itemMapper.update(itemVO);
	}
	
	@Override
	public int delete(int itemNo) {
		return this.itemMapper.delete(itemNo);
	}
}
