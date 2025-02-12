package kr.or.ddit.order.jy.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.alert.jy.mapper.AlertMapper;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.order.jy.mapper.OrderMapper;
import kr.or.ddit.order.jy.service.OrderService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BillVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.StoreOrderDetailVO;
import kr.or.ddit.vo.StoreOrderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AlertService alertService;
	
	@Autowired
	AlertMapper alertMapper;
	
	// 전체 품목 행 개수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.orderMapper.getTotal(map);
	}

	// 가맹점 발주(주문) insert
	@Transactional
	@Override
	public int insertOrder(StoreOrderVO storeOrderVO) {
		
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = storeOrderVO.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("updateOrder -> fileGroupNo: "+fileGroupNo);
			log.info("updateOrder -> uploadFiles: " + Arrays.toString(storeOrderVO.getUploadFiles()));
			
			/*
			 StoreOrderVO(storeOrderNo=159, storeNo=1, storeOrderDate=2025-01-15, fileGroupNo=20250115001, storeOrderStatus=0, 
			 storeOrderSum=200000, selectedItems=null, storeOrderDetailList=null, totalPrice=0, 
			 uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@50e05bcc], 
			 fileGroupVO=null)
			 */
			storeOrderVO.setFileGroupNo(fileGroupNo);
		}
		
		return this.orderMapper.insertOrder(storeOrderVO);
	}

	// 가맹점 발주 상세 insert
	@Override
	public int insertOD(StoreOrderDetailVO storeOrderDetailVO) {
		return this.orderMapper.insertOD(storeOrderDetailVO);
	}

	// 가맹점 발주 상세 update
	@Transactional
	@Override
	public int updateOD(List<StoreOrderDetailVO> storeOrderDetailList) {
		return this.orderMapper.updateOD(storeOrderDetailList);
	}
	
	// 가맹점 발주 update
	@Transactional
	@Override
	public int updateOrder(StoreOrderVO storeOrderVO) {
		
		int result = 0;
		/*
		 StoreOrderVO(storeOrderNo=159, storeNo=1, storeOrderDate=2025-01-15, fileGroupNo=0, storeOrderStatus=0, 
		 storeOrderSum=200000, selectedItems=null, storeOrderDetailList=null, totalPrice=0, 
		 uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@50e05bcc], 
		 fileGroupVO=null)
		 */
		log.info("updateOrder -> storeOrderVO: "+ storeOrderVO);
		
		// 다중 파일 업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = storeOrderVO.getUploadFiles();
		
		if(uploadFiles !=null && uploadFiles[0].getOriginalFilename().length() >0) {
			
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("updateOrder -> fileGroupNo: "+fileGroupNo);
			log.info("updateOrder -> uploadFiles: " + Arrays.toString(storeOrderVO.getUploadFiles()));
			
			/*
			 StoreOrderVO(storeOrderNo=159, storeNo=1, storeOrderDate=2025-01-15, fileGroupNo=20250115001, storeOrderStatus=0, 
			 storeOrderSum=200000, selectedItems=null, storeOrderDetailList=null, totalPrice=0, 
			 uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@50e05bcc], 
			 fileGroupVO=null)
			 */
			storeOrderVO.setFileGroupNo(fileGroupNo);
		}
		
		result += this.orderMapper.updateOrder(storeOrderVO);
		log.info("updateOrder -> result : "+result);
		
		// 알림 발송
		if(result > 0){
	        try {
	            // 알림 내용 설정
	        	List<EmployeeVO> recipients = determineRecipients(); // 수신자 결정 메서드
	            if(recipients == null || recipients.isEmpty()) {
	                log.error("수신자 에러");
	                return result;
	            }
	            String content = "발주 번호 " + storeOrderVO.getStoreOrderNo() + "번 " +storeOrderVO.getStoreNo()+ "호점의 계산서 요청";
	            int alertType = 4; // 주문 업데이트 알림 타입
	            String alertPk = String.valueOf(storeOrderVO.getStoreOrderNo());
	            String alertUrl = "/bonsa/order#order"; 
	            
	            for(EmployeeVO recipient : recipients) {
	                String recipientUserNo = recipient.getUserNo();
	                
	                log.info("updateOrder -> recipientUserNo : " + recipientUserNo);
	                
	                alertService.alert(recipientUserNo, content, alertType, alertPk, alertUrl);
	            }
	        } catch (Exception e) {
	            log.error("알림 전송 실패: ", e);
	        }
	    }
	    
	    return result;
	}
	
	// 재정팀 직원 찾기
	private List<EmployeeVO> determineRecipients() {
		return alertMapper.findJJ();
	}


	
	// 가맹점 계산 목록
	@Override
	public List<BillVO> billList(Map<String, Object> map) {
		return this.orderMapper.billList(map);
	}

	// 가맹점 계산 전체 행 개수
	@Override
	public int getBTotal(Map<String, Object> map) {
		return this.orderMapper.getBTotal(map);
	}

	// storeOrderNo 체크
	@Override
	public int checkNo(int storeOrderNo) {
		return this.orderMapper.checkNo(storeOrderNo);
	}

	// 본사 - 가맹점 발주 전체 행 개수
	@Override
	public int getOTotal(Map<String, Object> map) {
		return this.orderMapper.getOTotal(map);
	}

	// 본사 - 가맹점 발주 리스트
	@Override
	public List<StoreOrderVO> orderList(Map<String, Object> map) {
		return this.orderMapper.orderList(map);
	}

	// 본사 - 가맹점 발주 상세 조회
	@Override
	public List<StoreOrderDetailVO> orderDetailList(Map<String, Object> map) {
		return this.orderMapper.orderDetailList(map);
	}

	// 본사 - 가맹점 발주 상태 update
	@Override
	public int updateStatus(int storeOrderNo, int status) {
		return this.orderMapper.updateStatus(storeOrderNo, status);
	}

	
	// 본사 - storeorder 테이블에 billNO update
	@Override
	public int updateBillNo(int storeOrderNo, int billNo) {
		return this.orderMapper.updateBillNo(storeOrderNo, billNo);
	}

	// 본사 - 계산서 발행 시 발주 테이블 정보 가져오기
	@Override
	public StoreOrderVO getStoreOrder(int storeOrderNo) {
		return this.orderMapper.getStoreOrder(storeOrderNo);
	}

	// 본사 - 계산서 발행 후 상태 변경(승인)
	@Override
	public int updateOStatus(int billNo) {
		return this.orderMapper.updateOStatus(billNo);
	}

	
	// 본사 발주 현황
	@Override
	public List<StoreOrderVO> statusAjax(StoreOrderVO storeOrderVO) {
		return this.orderMapper.statusAjax(storeOrderVO);
	}
	
	
	// 가맹점별 발주 전체 행 개수
	@Override
	public int getGmjOtotal(Map<String, Object> map) {
		return this.orderMapper.getGmjOtotal(map);
	}

	// 가맹점별 발주 리스트
	@Override
	public List<StoreOrderVO> gmjOrderList(Map<String, Object> map) {
		return this.orderMapper.gmjOrderList(map);
	}

	// 가맹점 발주 회수
	@Override
	public int cancelOrder(List<StoreOrderVO> storeOrderList) {
		return this.orderMapper.cancelOrder(storeOrderList);
	}

	// 가맹점 발주 현황
	@Override
	public List<StoreOrderVO> gmjStatusAjax(StoreOrderVO storeOrderVO) {
		return this.orderMapper.gmjStatusAjax(storeOrderVO);
	}

	
	
	/* 가맹점 재발주
	@Override
	public int reorder(StoreOrderVO storeOrderVO) {
		return this.orderMapper.reorder(storeOrderVO);
	}
	*/
	
	


	

}
