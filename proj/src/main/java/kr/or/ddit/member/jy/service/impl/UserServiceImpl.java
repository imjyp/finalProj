package kr.or.ddit.member.jy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dept.jy.service.DeptService;
import kr.or.ddit.member.jy.mapper.UserMapper;
import kr.or.ddit.member.jy.service.UserService;
import kr.or.ddit.position.jy.service.PositionService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PositionVO;
import kr.or.ddit.vo.StoreEmpVO;
import kr.or.ddit.vo.TBUserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	DeptService deptService;

	@Autowired
	PositionService positionService;

	@Autowired
	UserMapper userMapper;

	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	UploadController uploadController;

	// 회원 가입
	/*
	 * MemberVO(memId=u001, memName=성원태2, memPw=java, memEnable=false ,
	 * memRegdate=null,fileGroupNo=0, uploadFiles=파일객체들
	 */
	/*
	 * 트랜잭션 자동 처리 하나의 트랜잭션에 여러 개의 SQL이 처리됨 FILE_GROUP Insert -> FILE_DETAIL Insert
	 * -> TB_MEMBERS Insert -> TB_AUTHS Insert 성공 성공 성공 실패 취소 취소 취소 ROLLBACK
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int save(TBUserVO userVO) {
		// 암호화(encrypt) 처리
		String password = userVO.getUserPw();
		password = this.bCryptPasswordEncoder.encode(password);
		log.info("save->password : " + password);

		// 1. 다중파일업로드
		MultipartFile[] uploadFiles = userVO.getUploadFiles();
		if (uploadFiles != null && uploadFiles[0].getOriginalFilename().length() > 0) {
			Long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			// 첨부파일이 있을 때
			if(uploadFiles.length > 0) {
				userVO.setUserProfile(fileGroupNo);
			}
			if(uploadFiles.length > 0) {
				userVO.setUserSign(fileGroupNo);
			}
		}

		// 패스워드를 저장 시 시큐리티를 설정하며 패스워드 인코딩용으로 등록한 빈을 사용해서 암호화한 후에 저장
		userVO.setUserPw(password);

		// 2. TB_MEMBERS 테이블에 insert
		int result = this.userMapper.save(userVO);

		// 3. TB_AUTHS 테이블에 pending 권한 insert
		AuthVO authVO = new AuthVO();
		authVO.setUserNo(userVO.getUserNo());
		authVO.setAuthName("ROLE_PENDING");
		result += this.userMapper.pending(authVO);

		return result;
	}

	// 상세정보 입력
	@Transactional
	@Override
	public int details(TBUserVO userVO) {

		 log.info("details -> userVO: {}", userVO);

		    // 부서 목록 가져오기
		    List<DeptVO> deptList = deptService.listAll();
		    log.info("details -> deptList: {}", deptList);

		    // 직책 목록 가져오기
		    List<PositionVO> positionList = positionService.listAll();
		    log.info("details -> positionList: {}", positionList);

		    // 선택된 부서와 직책을 처리
		    DeptVO selectedDept = null;
		    PositionVO selectedPosition = null;

		    // 부서 선택 처리
		    for (DeptVO dept : deptList) {
		        if (dept.getDeptNo().equals(userVO.getDeptNo())) {
		            selectedDept = dept;
		            break;
		        }
		    }

		    // 직책 선택 처리
		    for (PositionVO position : positionList) {
		        if (position.getPositionNo().equals(userVO.getPositionNo())) {
		            selectedPosition = position;
		            break;
		        }
		    }

		    // 본사 직원인지 가맹점 직원인지 처리
		    if (userVO.getUserCode() == 1) {  // 본사 직원
		    	
		    	// 본사 직원은 가맹점 정보가 없으므로 null 설정
		    	userVO.setStoreNo(null);  
		    	userVO.setStoreNm(null);
		        if (selectedDept != null) {
		            userVO.setDeptNo(selectedDept.getDeptNo());
		        }
		        if (selectedPosition != null) {
		            userVO.setPositionNo(selectedPosition.getPositionNo());
		        }
		    } else {  // 가맹점 직원
		    	// 가맹점 직원은 부서가 없으므로 null 설정
		        userVO.setDeptNo(null);  
		        if (selectedPosition != null) {
		            userVO.setPositionNo(selectedPosition.getPositionNo());
		        }
		    }

		    // TBUser 테이블 업데이트
		    int result = userMapper.details(userVO);
		    if (result > 0) {
		        if (userVO.getUserCode() == 1 || userVO.getUserCode() == 3) { // 본사 직원
		            EmployeeVO employeeVO = new EmployeeVO();
		            employeeVO.setUserNo(userVO.getUserNo());
		            employeeVO.setDeptNo(userVO.getDeptNo());
		            employeeVO.setPositionNo(userVO.getPositionNo());

		            // 상사가 없는 경우 null로 설정
		            employeeVO.setEmpManager(userVO.getEmpManager() == null || userVO.getEmpManager().isEmpty() ? null : userVO.getEmpManager());

		            result = userMapper.saveEmployee(employeeVO);
		            log.info("employee result : {} ", result);
		            
		        } else { // 가맹점 직원
		            StoreEmpVO storeEmpVO = new StoreEmpVO();
		            storeEmpVO.setUserNo(userVO.getUserNo());
		            storeEmpVO.setStoreNo(userVO.getStoreNo());
		            storeEmpVO.setStoreNm(userVO.getStoreNm());
		            storeEmpVO.setPositionNo(userVO.getPositionNo());
		            result = userMapper.saveStoreEmp(storeEmpVO);
		            log.info("stroeEmp result : {} ", result);
		        }
		    }

		    log.info("deptNo: {}", userVO.getDeptNo());
		    log.info("storeNo: {}", userVO.getStoreNo());

		    return result;
		}


	// 아이디 중복 검사
	@Override
	public int idDupChk(TBUserVO userVO) {
		return this.userMapper.idDupChk(userVO);
	}



}
