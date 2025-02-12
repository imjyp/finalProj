package kr.or.ddit.budget.jc.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.vo.HeadBudgetVO;
import kr.or.ddit.vo.StoreVO;

public interface iBudgetService {
	
	/**
	 * 본사 예산 정보 불러오기
	 * @return
	 */
	List<HeadBudgetVO> getBudget();

	/**
	 * 가맹점 예산 불러오기
	 * @return
	 */
	List<StoreVO> getBudget2();

	/**
	 * 가맹점 리스트 불러오기
	 * @return
	 */
	List<StoreVO> gmjList();

	/**
	 * 예산 총 개수 가져오기
	 * @param map
	 * @return
	 */
	int getTotal(Map<String, Object> map);

	/**
	 * 예산 리스트 조회하기
	 * @param map
	 * @return
	 */
	List<HeadBudgetVO> ysgrlist(Map<String, Object> map);

	/**
	 * 본사 예산 등록
	 * @param map
	 * @return
	 */
	int insertBudget(Map<String, Object> map);

	/**
	 * 본사 예산 수정
	 * @param map
	 * @return
	 */
	int updateBudget(Map<String, Object> map);

	/**
	 * 본사 예산 관리 조회
	 * @param map
	 * @return
	 */
	List<HeadBudgetVO> yssylist(Map<String, Object> map);

	/**
	 * 예산 년도 리스트
	 * @return
	 */
	List<HeadBudgetVO> yearlist();

	/**
	 * 가맹점별 예산 관리 조회
	 * @return
	 */
	List<StoreVO> ysgrlist2(Map<String, Object> map);

	/**
	 * 가맹점 예산 총 개수 가져오기
	 * @param map
	 * @return
	 */
	int getTotal2(Map<String, Object> map);

	/**
	 * 가맹점 예산 내역 조회
	 * @param map
	 * @return
	 */
	List<HeadBudgetVO> yssylist2(Map<String, Object> map);

	/**
	 * 가맹점별 예산 년도 출력
	 * @param storeNo
	 * @return
	 */
	List<HeadBudgetVO> yearlist2(int storeNo);

	/**
	 * 가맹점 예산 등록
	 * @param map
	 * @return
	 */
	int insertBudget2(Map<String, Object> map);

	/**
	 * 가맹점 예산 수정
	 * @param map
	 * @return
	 */
	int updateBudget2(Map<String, Object> map);

	int deleteBudget(Map<String, Object> map);

	int chkDelete(Map<String, Object> map);

	int getTotalBS();

	int getTotalGMJ();
	

}
