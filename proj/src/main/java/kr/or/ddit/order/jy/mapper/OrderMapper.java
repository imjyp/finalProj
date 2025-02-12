package kr.or.ddit.order.jy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.EstimateVO;
import kr.or.ddit.vo.ItemVO;
import kr.or.ddit.vo.StoreOrderDetailVO;
import kr.or.ddit.vo.StoreOrderVO;

@Mapper
public interface OrderMapper {

	// 전체 행 개수
	public int getTotal(Map<String, Object> map);

	// 가맹점 발주(주문) insert
	public int insertOrder(StoreOrderVO storeOrderVO);
	
	// 가맹점 발주 상세 insert
	public int insertOD(StoreOrderDetailVO storeOrderDetailVO);

	// 가맹점 발주 상세 update
	public int updateOD(List<StoreOrderDetailVO> storeOrderDetailList);
	
	// 가맹점 발주 update
	public int updateOrder(StoreOrderVO storeOrderVO);

	// 가맹점 계산 목록
	public List<BillVO> billList(Map<String, Object> map);

	// 가맹점 계산 전체 행 개수
	public int getBTotal(Map<String, Object> map);

	// storeOrderNo 체크
	public int checkNo(int storeOrderNo);

	// 본사 - 가맹점 발주 전체 행 개수
	public int getOTotal(Map<String, Object> map);

	// 본사 - 가맹점 발주 리스트
	public List<StoreOrderVO> orderList(Map<String, Object> map);

	// 본사 - 가맹점 발주 상세 조회
	public List<StoreOrderDetailVO> orderDetailList(Map<String, Object> map);

	// 본사 - 가맹점 발주 상태 update
	public int updateStatus(int storeOrderNo, int status);

	// 본사 - storeorder 테이블에 billNO update
	public int updateBillNo(int storeOrderNo, int billNo);

	// 본사 - 계산서 발행 시 발주 테이블 정보 가져오기
	public StoreOrderVO getStoreOrder(int storeOrderNo);

	// 본사 - 계산서 발행 후 상태 변경(승인)
	public int updateOStatus(int billNo);

	// 가맹점별 발주 전체 행 개수
	public int getGmjOtotal(Map<String, Object> map);

	// 가맹점별 발주 리스트
	public List<StoreOrderVO> gmjOrderList(Map<String, Object> map);

	// 가맹점 발주 회수
	public int cancelOrder(List<StoreOrderVO> storeOrderList);

	// 가맹점 발주 현황
	public List<StoreOrderVO> gmjStatusAjax(StoreOrderVO storeOrderVO);

	// 본사 발주 현황
	public List<StoreOrderVO> statusAjax(StoreOrderVO storeOrderVO);

	// billNo에 해당하는 StoreOrderNo 찾기
	public int findStoreOrderNo(int billNo);

	// 가맹점 재발주
//	public int reorder(StoreOrderVO storeOrderVO);
	


	

}
