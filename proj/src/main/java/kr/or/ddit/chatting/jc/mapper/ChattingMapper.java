package kr.or.ddit.chatting.jc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ChatVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.UsersVO;

@Mapper
public interface ChattingMapper {

	int inserMsg(ChatVO chatvo);

	int createPost(ChatVO chatvo);

	List<FileDetailVO> selectFileDetail(long fileGroupNo);

	List<EmployeeVO> listPeople();

	List<EmployeeVO> filter(Map<String, Object> map);

	// /chattingRoom에서 이름을 클릭 시 채팅창에 관련된 채팅내역 출력
	List<ChatVO> chatSendList(Map<String, Object> map);
}
