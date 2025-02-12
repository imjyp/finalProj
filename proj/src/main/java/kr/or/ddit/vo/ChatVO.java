package kr.or.ddit.vo;


import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ChatVO {
	
	
	private int chatRoomNo;
	private String userNo;
	
	private int chatSendNo;
	private String chatSendContent;
	private long fileGroupNo;
	private Date chatSendDate;
	private int chatSendDel;
	
	private String receiverNo;
	private String userNm;
	private String senderNo;
	
	private String chatRoomNm;
	private int chatRoomStatus;
	private Date chatRoomCreate;
	private int chatRoomDel;
	
	private int chatNo;
	private Date rcptnDate;
	private int rcptnDel;
	private int rcptnChk;
	
	private MultipartFile[] uploadFiles;
	private String fileGroupNm;
	private Date fileRegdate;
	private int fileGroupTy;
	
	private int    fileNo;
	private String fileOriginalName;
	private String fileSaveName;
	private String fileSaveLocate;
	private long   fileSize;
	private String fileExt;
	private String fileMime;
	private String fileFancysize;
	private Date   fileSaveDate;
	private int    fileDowncount;

}
