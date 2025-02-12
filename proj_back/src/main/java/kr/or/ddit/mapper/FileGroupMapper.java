package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.FileGroupVO;

@Mapper
public interface FileGroupMapper {

	//FILE_GROUP 테이블에 insert
	//<insert id="insertFileGroup" parameterType="fileGroupVO">
	public int insertFileGroup(FileGroupVO fileGroupVO);

	//FILE_DETAIL 테이블에 insert
	//FileDetailVO(fileSn=1, fileGroupNo=20241119005, fileOriginalName=111.jpg, fileSaveName=f4139448-65fc-41b3-a4f6-baf719fb0a05_111.jpg, fileSaveLocate=/resources/upload/2024/11/19/f4139448-65fc-41b3-a4f6-baf719fb0a05_111.jpg, fileSize=306350, fileExt=jpg, fileMime=image/jpeg, fileFancysize=299.17 KB, fileSaveDate=null, fileDowncount=0)
	public int insertFileDetail(FileDetailVO fileDetailVO);
	
}









