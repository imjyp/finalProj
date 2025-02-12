package kr.or.ddit.bill.jy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.StoreOrderVO;

@Mapper
public interface BillMapper {

	// 가맹점 계산 목록
	public List<BillVO> list(Map<String, Object> map);

	// 가맹점 계산 전체 행 개수
	public int getTotal(Map<String, Object> map);

	// 본사 계산서 상세
	public BillVO billDetail(Map<String, Object> map);
		
	// 본사 발주 반려
	public int updOS(List<StoreOrderVO> storeOrderList);

	// 본사 계산 insert 및 발주 billNo update
	public int insertBill(BillVO billVO);

	// 본사 계산 update 
	public int updateBill(BillVO billVO);

	// 가맹점 계산서 발행 리스트
	public List<BillVO> gmjBList(Map<String, Object> map);

	// 가맹점 계산 전체 행 개수
	public int getgmjBTotal(Map<String, Object> map);

	// 가맹점 계산서 detail
	public BillVO gmjBillDetail(Map<String, Object> map);

	// 가맹점 계산 전체 행 개수
	public int getGmjSTotal(Map<String, Object> map);

	

	
}
