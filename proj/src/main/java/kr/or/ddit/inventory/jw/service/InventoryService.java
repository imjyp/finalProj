package kr.or.ddit.inventory.jw.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.inventory.jw.vo.InventoryVO;
import kr.or.ddit.vo.ItemVO;

public interface InventoryService {

	//재고 목록 수 
	public int inventoryTotal(Map<String, Object> map);
	
	//재고 목록
	public List<ItemVO> inventoryList(Map<String, Object> map);

	//재고 상세정보 목록 수
	public int inventoryDetailTotal(Map<String, Object> map);

	//재고 상세정보
	public List<InventoryVO> inventoryDetailList(Map<String, Object> map);

	//품목 리스트
	public List<ItemVO> getItem();

	//재고 등록
	public int create(List<InventoryVO> map);

	//안전재고 변경
	public int updateSafetyAmount(List<ItemVO> map);

	//출고 품목 리스트 수
	public int inventoryOutgoingTotal(Map<String, Object> map);

	//출고 품목 리스트 
	public List<InventoryVO> inventoryOutgoingList(Map<String, Object> map);

	

}
