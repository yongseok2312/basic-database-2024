import java.io.*;
import java.sql.*;

public class BookList {
	Connection con;

	public BookList() {
	  String Driver="";
          String url="jdbc:sqlserver://localhost:1433;DatabaseName=Madang;";
          String userid="madanguser";
          String pwd="madangpass";

	   try { /* ����̹��� ã�� ���� */
	     Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	     System.out.println("����̹� �ε� ����");
	   } catch(ClassNotFoundException e) {
		e.printStackTrace();
	     }

	   try { /* �����ͺ��̽��� �����ϴ� ���� */
	     System.out.println("�����ͺ��̽� ���� �غ� ...");
	     con=DriverManager.getConnection(url, userid, pwd);
	     System.out.println("�����ͺ��̽� ���� ����");
	     } catch(SQLException e) {
	         e.printStackTrace( );
		}
	   }

	   private void sqlRun( ) {
	     String query="SELECT * FROM Book"; /* SQL �� */
	     try { /* �����ͺ��̽��� ���� ����� �������� ���� */
		   Statement stmt=con.createStatement();
		   ResultSet rs=stmt.executeQuery(query);
		   System.out.println("BOOK NO \tBOOK NAME \t\tPUBLISHER \tPRICE");
		   while(rs.next( )) {
			   System.out.print("\t"+rs.getInt(1));
			   System.out.print("\t"+rs.getString(2));
			   System.out.print("\t\t"+rs.getString(3));
			   System.out.println("\t"+rs.getInt(4));
		   }

		   con.close( );
	     } catch(SQLException e) {
		     e.printStackTrace( );
		}
	}

	public static void main(String args[ ]) {
	   BookList so=new BookList( );
	   so.sqlRun();
	}
}