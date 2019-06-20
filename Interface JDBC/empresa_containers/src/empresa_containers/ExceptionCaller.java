package empresa_containers;

import java.net.ConnectException;
import java.sql.SQLException;

public class ExceptionCaller {
	
	public static void connect_Exception(SQLException ex) {
		int erroCode = ex.getErrorCode();
		String erroString = ex.getMessage();
		System.out.println("N�o foi poss�vel estabelecer conex�o com o servidor. \nErro n�mero " + erroCode + ": " + erroString );
		System.exit(1);
	}
	
	public static void connect_Exception(Exception ex) {
		String erroCause = ex.getCause().toString();
		String erroString = ex.getMessage();
		System.out.println("Erro n�mero " + erroCause + ": " + erroString );
		System.exit(1);
	}
	
	public static void sqlString_Exception(SQLException ex, String str) {
		System.out.println(str + ex.getErrorCode() + ": " +
							ex.getMessage());
		System.exit(1);
	}

}
