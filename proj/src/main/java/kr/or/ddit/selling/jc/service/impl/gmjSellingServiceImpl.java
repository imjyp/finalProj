package kr.or.ddit.selling.jc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.selling.jc.mapper.gmjSellingMapper;
import kr.or.ddit.selling.jc.service.igmjSellingService;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.SellingVO;

@Service
public class gmjSellingServiceImpl implements igmjSellingService{

	@Autowired
	gmjSellingMapper sellMapper;

	@Override
	public List<SellingVO> getAll(Map<String, Object> map) {
		return this.sellMapper.getAll(map);
	}

	@Override
	public List<MenuVO> getMenu() {
		return this.sellMapper.getMenu();
	}

	@Override
	public String selgmj(int storeNo) {
		return this.sellMapper.selgmj(storeNo);
	}

	@Override
	public List<SellingVO> bestseller(Map<String, Object> map) {
		return this.sellMapper.bestseller(map);
	}

	@Override
	public List<SellingVO> getYear(int storeNo) {
		return this.sellMapper.getYear(storeNo);
	}

	@Override
	public List<SellingVO> getMonth(int storeNo) {
		return this.sellMapper.getMonth(storeNo);
	}

	@Override
	public List<SellingVO> getBSYear() {
		return this.sellMapper.getBSYear();
	}

	@Override
	public List<SellingVO> getBSMonth() {
		return this.sellMapper.getBSMonth();
	}

	@Override
	public List<SellingVO> dateGraph(Map<String, Object> map) {
		return this.sellMapper.dateGraph(map);
	}

	@Override
	public List<SellingVO> dateGraph2(Map<String, Object> map) {
		return this.sellMapper.dateGraph2(map);
	}

	@Override
	public List<SellingVO> compareWithLast(Map<String, Object> map) {
		return this.sellMapper.compareWithLast(map);
	}

	@Override
	public List<SellingVO> bsItem(Map<String, Object> map) {
		return this.sellMapper.bsItem(map);
	}

	@Override
	public List<SellingVO> bsMenu(Map<String, Object> map) {
		return this.sellMapper.bsMenu(map);
	}

	@Override
	public List<SellingVO> bsMargin(Map<String, Object> map) {
		return this.sellMapper.bsMargin(map);
	}

	@Override
	public List<SellingVO> bsBudget(Map<String, Object> map) {
		return this.sellMapper.bsBudget(map);
	}

	@Override
	public List<SellingVO> lastcompare(Map<String, Object> map) {
		return this.sellMapper.lastcompare(map);
	}

	@Override
	public List<SellingVO> storeNm() {
		return this.sellMapper.storeNm();
	}

	@Override
	public List<SellingVO> bsBestSellerItem(Map<String, Object> map) {
		return this.sellMapper.bsBestSellerItem(map);
	}

	@Override
	public List<SellingVO> bsBestSellerMenu(Map<String, Object> map) {
		return this.sellMapper.bsBestSellerMenu(map);
	}

	@Override
	public List<SellingVO> bestsellerTop5(Map<String, Object> map) {
		return this.sellMapper.bestsellerTop5(map);
	}

	@Override
	public List<SellingVO> bsBestSellerItemTop5(Map<String, Object> map) {
		return  this.sellMapper.bsBestSellerItemTop5(map);
	}

	@Override
	public List<SellingVO> bsBestSellerMenuTop5(Map<String, Object> map) {
		return  this.sellMapper.bsBestSellerMenuTop5(map);
	}

	@Override
	public List<SellingVO> bsGMJMargin(Map<String, Object> map) {
		return this.sellMapper.bsGMJMargin(map);
	}

	/*
	매출 등록 요청 : 
	SellingVO(sellingNo=0, storeNo=1, sellingDate=null, 
	sellingTotal=9000, sellingDetailNo=0, menuNo=3, 
	sellingAmount=3, menuNm=null, menuPrice=0, ctgryNm=null, 
	storeNm=null, year=0, month=0, rank=0, totalAmount=0, 
	quarter=null, quarterlySales=0, monthlySales=0, 
	monthS=null, yearlySales=0, yearS=null, quarterY=null, 
	quarterlyYSales=0, monthlyYSales=0, monthY=null, 
	yearlyYSales=0, yearY=null, storeBudgetDate=null, 
	storeBudgetTy=0, lastYearSales=0, thisYearSales=0, 
	growthRate=0, tm=null, lm=null, salePrice=0, itemNo=0, 
	itemNm=null, itemPrice=0, totalItem=0, total=0, totalMenu=0)
	 */
	@Override
	public SellingVO mchdr(SellingVO sellingVO) {
		//1. SELLING 테이블에 insert
		
		int result = this.sellMapper.mchdrSelling(sellingVO);
		//나갈때 : SellingVO(sellingNo=138,..
				
		//2. SELLING_DETAIL 테이블에 insert
		result += this.sellMapper.mchdrSellingDetail(sellingVO);
		//나갈때 : SellingVO(sellingNo=138, .., sellingDetailNo=227,..
		
		return sellingVO;
	}

	@Override
	public List<SellingVO> lastcompareyear(Map<String, Object> map) {
		return this.sellMapper.lastcompareyear(map);
	}

	@Override
	public List<SellingVO> gmjrank(Map<String, Object> map) {
		return this.sellMapper.gmjrank(map);
	}

	// 본사 매출(매출,예산,작년 종합)
	@Override
	public List<SellingVO> getTable(Map<String, Object> map) {
		return this.sellMapper.getTable(map);
	}

	@Override
	public List<SellingVO> compareWithLastyear(Map<String, Object> map) {
		return this.sellMapper.compareWithLastyear(map);
	}

	@Override
	public List<SellingVO> getTable2(Map<String, Object> map) {
		return this.sellMapper.getTable2(map);
	}
	
	
}
