package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Procedures {
	
	public static void proc_inserePedido(String cpf, String rg, String cnpj, String destinatario) throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = Insercao.preparedStatementPreForm_Procedure("PROC_inserePedido", 4);
			
			//String sql = "CALL PROC_inserePedido( '" + cpf +"', '" + rg +"', '" + cnpj +"', '" + destinatario +"')";
			
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, cpf, rg, cnpj, destinatario);
				
				statement.execute(sql);
				
				System.out.println("Pedido Inserido com sucesso!");
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}
		
		return ;
		
	}
	
	public static void proc_insereCliente(String cpf, String rg, String cnpj, String razaosocial, String cep,
			String emailCliente, String nome, String endereco, String telefone) throws SQLException {
		
			try(Connection connection = new ConnectionPool().connect()){
			
				int idMaximo;
				
				String sql = Insercao.preparedStatementPreForm_Procedure("PROC_insereCliente", 9);
				
				//String sql = "CALL PROC_inserePedido( '" + cpf +"', '" + rg +"', '" + cnpj +"', '" + destinatario +"')";
				
				
				try(PreparedStatement statement = connection.prepareStatement(sql)){
					
					Insercao.fill_Interrogations_With_Values(statement, cpf, rg, cnpj, razaosocial, cep, emailCliente,
							nome, endereco, telefone);
					
				statement.execute(sql);
				
				System.out.println("Pedido Inserido com sucesso!");
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}
		
		return ;
		
	}
	
	public static void proc_insereSeguradora(String email, String cnpj, String razaoSocial, String nome, String telefone) throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
		
			int idMaximo;
			
			String sql = Insercao.preparedStatementPreForm_Procedure("PROC_insereSeguradora", 5);
			
			//String sql = "CALL PROC_inserePedido( '" + cpf +"', '" + rg +"', '" + cnpj +"', '" + destinatario +"')";
			
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, email, cnpj, razaoSocial, nome, telefone);
				
			statement.execute(sql);
			
			System.out.println("Pedido Inserido com sucesso!");
		}	catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
		
	}
	
	return ;
	
	}
	
	public static void proc_getProdutosEntreDatasPorRg(String rg, String dataInicio, String dataFim) throws SQLException {
		
			try(Connection connection = new ConnectionPool().connect()){
			
				int idMaximo;
				
				String sql = Insercao.preparedStatementPreForm_Procedure("PROC_getProdutosEntreDatasPorRg", 3);
				
				//String sql = "CALL PROC_inserePedido( '" + cpf +"', '" + rg +"', '" + cnpj +"', '" + destinatario +"')";
				
				
				try(PreparedStatement statement = connection.prepareStatement(sql)){
					
					Insercao.fill_Interrogations_With_Values(statement, rg, dataInicio, dataFim);
					
				statement.execute(sql);
				
				System.out.println("Pedido Inserido com sucesso!");
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}
		
		return ;
		
	}
	
	public static void proc_getProdutosEntreDatasPorCpf(String cpf, String dataInicio, String dataFim) throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
		
			int idMaximo;
			
			String sql = Insercao.preparedStatementPreForm_Procedure("PROC_getProdutosEntreDatasPorCpf", 3);
			
			//String sql = "CALL PROC_inserePedido( '" + cpf +"', '" + rg +"', '" + cnpj +"', '" + destinatario +"')";
			
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, cpf, dataInicio, dataFim);
				
			statement.execute(sql);
			
			System.out.println("Pedido Inserido com sucesso!");
		}	catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
		
	}
	
	return ;
	
	}
	
	public static void proc_getProdutosEntreDatasPorCnpj(String cnpj, String dataInicio, String dataFim) throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
		
			int idMaximo;
			
			String sql = Insercao.preparedStatementPreForm_Procedure("PROC_getProdutosEntreDatasPorCnpj", 3);
			
			//String sql = "CALL PROC_inserePedido( '" + cpf +"', '" + rg +"', '" + cnpj +"', '" + destinatario +"')";
			
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, cnpj, dataInicio, dataFim);
				
			statement.execute(sql);
			
			System.out.println("Pedido Inserido com sucesso!");
		}	catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
		
	}
	
	return ;
	
	}
	

}
