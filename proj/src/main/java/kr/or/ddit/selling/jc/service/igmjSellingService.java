package kr.or.ddit.selling.jc.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.SellingVO;

public interface igmjSellingService {

	List<SellingVO> getAll(Map<String, Object> map);

	List<MenuVO> getMenu();

	String selgmj(int storeNo);

	List<SellingVO> bestseller(Map<String, Object> map);

	List<SellingVO> getYear(int storeNo);

	List<SellingVO> getMonth(int storeNo);

	List<SellingVO> getBSYear();

	List<SellingVO> getBSMonth();

	List<SellingVO> dateGraph(Map<String, Object> map);

	List<SellingVO> dateGraph2(Map<String, Object> map);

	List<SellingVO> compareWithLast(Map<String, Object> map);

	List<SellingVO> bsItem(Map<String, Object> map);

	List<SellingVO> bsMenu(Map<String, Object> map);

	List<SellingVO> bsMargin(Map<String, Object> map);

	List<SellingVO> bsBudget(Map<String, Object> map);

	List<SellingVO> lastcompare(Map<String, Object> map);

	List<SellingVO> storeNm();

	List<SellingVO> bsBestSellerItem(Map<String, Object> map);

	List<SellingVO> bsBestSellerMenu(Map<String, Object> map);

	List<SellingVO> bestsellerTop5(Map<String, Object> map);

	List<SellingVO> bsBestSellerItemTop5(Map<String, Object> map);

	List<SellingVO> bsBestSellerMenuTop5(Map<String, Object> map);

	List<SellingVO> bsGMJMargin(Map<String, Object> map);

	SellingVO mchdr(SellingVO sellingVO);

	List<SellingVO> lastcompareyear(Map<String, Object> map);

	List<SellingVO> gmjrank(Map<String, Object> map);

	// 본사 매출(매출,예산,작년 종합)
	List<SellingVO> getTable(Map<String, Object> map);

	List<SellingVO> compareWithLastyear(Map<String, Object> map);

	List<SellingVO> getTable2(Map<String, Object> map);

}
