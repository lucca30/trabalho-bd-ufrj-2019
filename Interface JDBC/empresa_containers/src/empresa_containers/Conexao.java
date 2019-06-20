package empresa_containers;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.hsqldb.DatabaseManager;

public class Conexao {

	public static void main(String[] args) throws SQLException, Exception {

		Connection connection = new ConnectionPool().connect();
		connection.close();
		
		System.out.println("Foi '-'");
		
	}

}
