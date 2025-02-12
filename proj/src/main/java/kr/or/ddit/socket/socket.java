package kr.or.ddit.socket;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;


public class socket {

	/*
	 * public static void main(String[] args) { /* 서버: ServerSocket() -> accept() ->
	 * IOstream 생성 -> read() -> write() -> read() -> close() 클라이언트 : Socket() ->
	 * IOstream 생성 -> write() -> read() -> close()
	 * 
	 * 
	 * 
	 * //서버에서 접속자가 있을때마다 소켓 생성함 ServerSocket server = new ServerSocket(포트번호);
	 * 
	 * Socket socket = server.accept(); //ServerSocket 클래스는 접속이 있을 때마다 소켓을 생성해주는
	 * accept()메소드가 있음 //accept() 메소드는 클라이언트로부터 접속이 올 때까지, 무한루프를 돌리고있고 접속이 들어오면 포트로
	 * 연결된 소켓을 생성, 반환하면서 무한루프를 끝냄 //그렇게 클라이언트는 서버의 새로운 소켓과 연결된 상태로 서비스를 사용하게 됨
	 * 
	 * 
	 * 
	 * //데이터 보낼때는 outputStream, 받을때는 inputStream //서버와 클라이언트 모두 stream이 존재해야함.
	 * stream은 데이터가 오고갈 수 있는 통로 //내가 데이터를 상대 pc로 보낼때는 나의 ram에서 나가는 것이기 때문에
	 * OutputStream을 열어야함 Socket socket2 = new Socket("ip", 포트번호); OutputStream os =
	 * socket.getOutputStream(); //OutputStream 생성 os.write(); //데이터 전송
	 * 
	 * DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
	 * //비포장도로 -> 포장도로 dos.writeInt(); dos.writeLong(); dos.writeUTF();
	 * 
	 * dos.flush(); //강제로 buffer 비우기
	 * 
	 * 
	 * //반대로 내가 데이터를 ram으로 받으려면 inputStream 사용 Socket socket = new Socket("ip",
	 * 포트번호); InputStream is = socket.getInputStream(); //InputStream 생성
	 * DataInputStream dis = new DataInputStream(is); dis.readInt(); dis.readLong();
	 * dis.readUTF();
	 * 
	 * 
	 * 
	 * 
	 * //File클래스는 HDD, SSD 같은 저장소에 있는 데이터를 CPU에서 처리하기 위해 ram에 투영시키기 위해 존재 File file
	 * = new File("주소"); //new file(주소)로 인스턴스 생성하는 순간 HDD에 있는 파일의 메타데이터가 메모리에 올라옴 ->
	 * 파일의 크기, 존재유무 등을 알 수 있음
	 * 
	 * System.out.println(file.exists()); System.out.println(file.length());
	 * System.out.println(file.isDirectory()); System.out.println(file.isFile());
	 * System.out.println(file.getParentFile()); System.out.println(file.getPath());
	 * 
	 * 
	 * 
	 * PC A -> PC B로 전송하는 과정 A: [HDD -> RAM] -> internet -> B:[RAM -> HDD]
	 * 
	 * 파일을 HDD같은 보조기억장치에 위치함 ram(주기억장치)에 올려놔야 cpu가 처리할 수 있음 => hdd에 있는 것을 ram으로 올리는
	 * 작업을 해야함
	 * 
	 * 
	 * 
	 * //HDD(A) -> RAM(A) File file = new File("주소"+ loadingFile); // 로딩 파일 인스턴스 생성
	 * FileInputStream fis = new FileInputStream(file); //파일이 들어올 inputstream 개방
	 * DataInputStream fsis = new DataInputStream(fis); //사용하기 편하게 만듦
	 * 
	 * byte[] filecontants = new byte[(int)file.length()]; // 파일을 담을 공간을 RAM에 생성
	 * fsis.readFully(filecontants); // RAM에 파일 업로드
	 * 
	 * 
	 * //RAM(A) -> internet -> RAM (B) DataOutputStream dos = new
	 * DataOutputStream(sock.getOutputStream()); // 파일을 보낼 Stream 개방
	 * dos.writeLong(filecontants.length); // 클라이언트 쪽에 파일의 크기를 전달
	 * dos.write(filecontants); // 파일 전송 dos.flush(); // 버퍼 비우기
	 * 
	 * // RAM(B) byte[] fileContants = new byte[(int)dis.readLong()]; // 전달받은 크기만큼
	 * RAM에 공간 생성 dis.readFully(fileContants); // RAM에 파일 저장
	 * 
	 * 
	 * //RAM(B) -> HDD(B) File dest = new File("C:/목적지/"+downFile); // 다운 받을 장소를
	 * RAM으로 끌어옴 FileOutputStream fos = new FileOutputStream(dest); // RAM - HDD 사이에
	 * Stream 개방 DataOutputStream dfos = new DataOutputStream(fos);
	 * dfos.write(fileContants); // dest에 정보를 입력 dfos.flush(); // 버퍼 비우기
	 * dfos.close(); // Stream 폐쇄
	 * 
	 * 
	 * }
	 */
}
