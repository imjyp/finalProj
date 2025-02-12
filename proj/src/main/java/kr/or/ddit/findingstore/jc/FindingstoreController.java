package kr.or.ddit.findingstore.jc;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.findingstore.jc.service.ifindStoreService;
import kr.or.ddit.vo.StoreVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FindingstoreController {

	
	@Autowired
	ifindStoreService findService;
	
	@GetMapping("/findingstore")
	public String alertPage() {
		return "gmjmanage/findstore";
	}
	
	
	@ResponseBody
	@PostMapping("/mapgmj")
	public List<StoreVO> mapgmj(@RequestBody Map<String, Object> map){
		String keyword= "";
		
		/*
		 * if(map.get("keyword") != null) { keyword = map.get("keyword").toString(); }
		 */
		List<StoreVO> stores = this.findService.map(map);
		log.info("stores 지도"+stores);
		
		return stores;
	}
	
	
	
}

