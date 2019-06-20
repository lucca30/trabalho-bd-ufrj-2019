package empresa_containers;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mysql.cj.jdbc.MysqlDataSource;

public class ConnectionPool {
	
	private DataSource dataSource;
	
	ConnectionPool(){
		MysqlDataSource pool = new MysqlDataSource();
		pool.setURL("jdbc:mysql://db4free.net:3306/remote_mysql");
		pool.setUser("lucas_sql");
		pool.setPassword("180897ll");
		this.dataSource = pool;
	}
	
	ConnectionPool(String strURL, String strUser, String strPass){
		  MysqlDataSource pool = new MysqlDataSource();
		  pool.setURL(strURL);
		  pool.setUser(strUser);
		  pool.setPassword(strPass);
		  this.dataSource = pool;
		 }

	/**
	 * Abre uma conexao com o banco de dados desejado seguindo os padroes do MySQL.
	 * String de conexao no fortamo "jdbc:mysql://[URL ou localhost]:3306/[Nome do banco]", "username", "password"
	 * @return Retorna um ponto da conecao aberta para se fazer as queries e tudo mais
	 * @throws SQLException
	 */
	Connection getConnection() throws SQLException, Exception {
		//Connection connection = DriverManager.getConnection("jdbc:mysql://db4free.net:3306/remote_mysql", "lucas_sql", "180897ll");
		Connection connection = dataSource.getConnection();
		return connection;
	}
	
	Connection connect() throws SQLException {
		Connection conn = null;
		try {
			conn = new ConnectionPool().getConnection();
			}	catch(SQLException ex) {
				ExceptionCaller.connect_Exception(ex);
			}	catch(Exception ex) {
				ExceptionCaller.connect_Exception(ex);
			}
		return conn;
	}


}
