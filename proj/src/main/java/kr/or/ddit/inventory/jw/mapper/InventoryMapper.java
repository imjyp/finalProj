package kr.or.ddit.inventory.jw.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.inventory.jw.vo.InventoryVO;
import kr.or.ddit.vo.ItemVO;

@Mapper
public interface InventoryMapper {

	//재고 목록 수
	public int inventoryTotal(Map<String, Object> map);

	//재고 목록
	public List<ItemVO> inventoryList(Map<String, Object> map);

	//재고 상세정보 목록 수
	public int inventoryDetailTotal(Map<String, Object> map);

	//재고 상세정보 목록
	public List<InventoryVO> inventoryDetailList(Map<String, Object> map);

	//품목 리스트
	public List<ItemVO> getItem();

	// 계산서 발행시 출고 insert
	public int insertInventory(InventoryVO inventoryVO);

	//재고 등록
	public int create(List<InventoryVO> map);

	//안전재고 변경
	public int updateSafetyAmount(List<ItemVO> map);

	// 출고 insert 시 유통기한 자동으로 입력되는 프로시저(PROC_AUTO_EXP_DATE(P_ITEM_NO IN NUMBER)) 실행
	public int excProcAutoExpDate(InventoryVO inventoryVO);

	// 출고 품목 리스트 수
	public int inventoryOutgoingTotal(Map<String, Object> map);

	// 출고 품목 리스트
	public List<InventoryVO> inventoryOutgoingList(Map<String, Object> map);

	//*******
    //INVNTRY_RECORD 테이블에서 특정 ITEM_NO 컬럼의 값에 대한 조건과 RECORD_TY = 1인
    //	데이터의 RECORD_AMOUNT 값을 REMAIN_AMOUNT 값으로 초기화 한 후 아래의 프로시저를 실행함
	public int preExcProcAutoExpDate(InventoryVO inventoryVO);

	
}
