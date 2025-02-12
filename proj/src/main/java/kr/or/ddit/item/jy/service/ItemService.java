package kr.or.ddit.item.jy.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ItemVO;

public interface ItemService {

	// 품목 리스트
	public List<ItemVO> list(Map<String, Object> map);
	
	// 전체 행 개수
	public int getTotal(Map<String, Object> map);
	
	// jsp에서 사용할 List<ItemVO> selectedItems
	public List<ItemVO> selectedItems(List<Integer> items);
}
