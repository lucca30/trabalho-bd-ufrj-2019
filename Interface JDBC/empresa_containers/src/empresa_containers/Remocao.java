package empresa_containers;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Remocao {
	
	/**
	 * Remove uma ou mais tuplas baseadas na condicao desejada. O SQL formado e no formato
	 * "DELETE FROM table WHERE condition ;"
	 * Note que dessa forma nao e possivel deletar a tabela inteira
	 * @param connection Conexao ja aberta com o banco de dados
	 * @param table Nome da tabela
	 * @param condition Condicao para se deletar uma ou mais tuplas da tabela
	 * @throws SQLException
	 * @throws ConnectException 
	 */
	public static void removeTupla(String table, String condition) throws SQLException, Exception {
		
		Connection connection = new ConnectionPool().getConnection();
		
		String sql = "DELETE FROM " + table + " WHERE " + condition + ";";
		Statement statement = connection.createStatement();

		statement.execute(sql);
		
		int count = statement.getUpdateCount();
		
		System.out.println(count + " Linha(s) Alterada(s)");
		
		statement.close();
		
		connection.close();
	}

	public static void main(String[] args) throws SQLException, Exception {


		removeTupla("Container", "IdContainer_PK = 301" );


	}



}
