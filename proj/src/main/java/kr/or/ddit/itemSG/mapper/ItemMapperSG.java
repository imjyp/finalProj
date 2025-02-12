package kr.or.ddit.itemSG.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ItemVO;

@Mapper
public interface ItemMapperSG {

	// 품목 리스트
	public List<ItemVO> itemList(Map<String, Object> map);

	// 전체 행 개수
	public int getTotal(Map<String, Object> map);
	
	//jsp에서 사용할 List<ItemVO> selectedItems
	public List<ItemVO> selectedItems(List<Integer> items);
	
	// 품목 상세 조회
	public ItemVO detail(int itemNo);
	
	// 품목 등록
	public int insert(ItemVO itemVO);
	
	// 품목 수정
	public int update(ItemVO itemVO);
	
	// 품목 삭제 (상태 변경)
	public int delete(int itemNo);

	// 품목 다중 삭제
	public int deleteItems(List<Integer> itemNos);
}
