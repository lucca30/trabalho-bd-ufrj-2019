package empresa_containers;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Insercao {
	
	/**
	 * Retorna uma String no formato "INSERT INTO table VALUES (?, ?, ?, ?, ..., ?);"
	 * Que e o formato que o preparedStatement recebe para posteriormente adicionar os
	 * valores das variaveis sem correr o risco de SQL Injection
	 * @param table Nome da tabela que se deseja fazer a Insercao
	 * @param strLength Numero de colunas da tabela. Consequentemente o numero de "?"
	 * @return String
	 */
	public static String preparedStatementPreForm_Insertion(String table, int strLength) {
		
		String sql = "INSERT INTO " + table + " VALUES (";
		for(int i = 1; i <= strLength; i++) {
			
			if(i == strLength)
				sql = sql + " ? ";
			else
				sql = sql + " ?, ";
			
		}
		sql = sql + "); ";
		return sql;
	}
	
	public static String preparedStatementPreForm_Procedure(String procedure, int strLength) {
		
		String sql = "CALL " + procedure + " (";
		for(int i = 1; i <= strLength; i++) {
			
			if(i == strLength)
				sql = sql + " ? ";
			else
				sql = sql + " ?, ";
			
		}
		sql = sql + "); ";
		return sql;
	}
	
	/**
	 * Preenche as "?"s da String gerada pelo preparedStatementPreForm_Insertion com os valores correspondentes
	 * @param statement O preparedStatement ja deve ter recebido a string com "?"
	 * @param strings Os valores de cada "?" podem ser passados como parametros separados
	 * @throws SQLException
	 */
	public static void fill_Interrogations_With_Values(PreparedStatement statement, String... strings)
			throws SQLException {
		for(int i = 1; i <= strings.length; i++) {
			statement.setString(i, strings[i-1]);
		}
	}
	
	/**
	 * Insere uma única tupla por vez. Deve-se passar todos os atributos em ordem
	 * @param connection Conexao ja aberta com o banco de dados
	 * @param table Nome da tabela
	 * @param strings N parametros, cada um contendo um valor de uma coluna da tabela
	 * @throws SQLException
	 * @throws ConnectException 
	 */
	public static void insereTupla(String table, String ...strings ) throws SQLException, Exception {
		
		Connection connection = new ConnectionPool().getConnection();
		
		String sql = preparedStatementPreForm_Insertion(table, strings.length);
			
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		fill_Interrogations_With_Values(statement, strings);
		
		statement.execute();
		
		int count = statement.getUpdateCount();
		
		System.out.println(count + " Linha(s) Alterada(s)");

		statement.close();
		
		connection.close();
		
		return;
	}


	public static void main(String[] args) throws SQLException, Exception {

		
		insereTupla("Seguradora", "101", "contato@vaique.com.br", "54781230257580", "Vai Que S/A", "Vai Que.. Seguradora", "21978445120" );



	}

}

/*
 * 
		statement.execute("INSERT INTO Seguradora (emailSeguradora, cnpj, razaoSocial, nome, telefone) "
				+ "VALUES ('contato@vaique.com.br', '54781230257580', 'Vai Que S/A', 'Vai Que.. Seguradora', '21978445120')",
				statement.RETURN_GENERATED_KEYS);
		
		ResultSet resultSet = statement.getGeneratedKeys();
		
		while(resultSet.next()) {
			String id = resultSet.getString("id");
			System.out.println(id + " gerado");
		}
		
		
		statement.execute("INSERT INTO Seguradora "
				+ "VALUES ('101', 'contato@vaique.com.br', '54781230257580', 'Vai Que S/A', 'Vai Que.. Seguradora', '21978445120')");
		
 * 
 * 
 */