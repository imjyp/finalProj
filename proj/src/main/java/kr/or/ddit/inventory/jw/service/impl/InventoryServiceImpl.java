package kr.or.ddit.inventory.jw.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.alert.jy.mapper.AlertMapper;
import kr.or.ddit.alert.jy.service.AlertService;
import kr.or.ddit.inventory.jw.mapper.InventoryMapper;
import kr.or.ddit.inventory.jw.service.InventoryService;
import kr.or.ddit.inventory.jw.vo.InventoryVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.ItemVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class InventoryServiceImpl implements InventoryService{

	@Autowired
	InventoryMapper inventoryMapper;
	

	@Override
	public int inventoryTotal(Map<String, Object> map) {
		return this.inventoryMapper.inventoryTotal(map);
	}

	@Override
	public List<ItemVO> inventoryList(Map<String, Object> map) {
		return this.inventoryMapper.inventoryList(map);
	}

	@Override
	public int inventoryDetailTotal(Map<String, Object> map) {
		return this.inventoryMapper.inventoryDetailTotal(map);
	}

	@Override
	public List<InventoryVO> inventoryDetailList(Map<String, Object> map) {
		return this.inventoryMapper.inventoryDetailList(map);
	}

	@Override
	public List<ItemVO> getItem() {
		return this.inventoryMapper.getItem();
	}

	@Override
	public int create(List<InventoryVO> map) {
		return this.inventoryMapper.create(map);
	}

	@Override
	public int updateSafetyAmount(List<ItemVO> map) {
		return this.inventoryMapper.updateSafetyAmount(map);
	}

	@Override
	public int inventoryOutgoingTotal(Map<String, Object> map) {
		return this.inventoryMapper.inventoryOutgoingTotal(map);
	}

	@Override
	public List<InventoryVO> inventoryOutgoingList(Map<String, Object> map) {
		return this.inventoryMapper.inventoryOutgoingList(map);
	}

	
	
	
	

	
}
