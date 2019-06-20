package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.modelo.Cliente;

public class Consultas {
	
	
	public static void id_Dos_Produtos_PF(String cpf) throws SQLException {
		
		ArrayList<Integer> lista = new ArrayList<>();
		
		try(Connection conn = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select idProduto_PK from Produto\n" + 
					" where idPedido_FK in (select idPedido_PK from Pedido \n" + 
					" where idCliente_FK in (select idCliente_PK from Cliente\n" + 
					" where idCliente_PK in (select idCliente_SPK from PessoaFisica\n" + 
					" where cpf = ? )));";
			
			try(PreparedStatement statement = conn.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, cpf);
				
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id = result.getInt(1);
						lista.add(id);
					}
					

					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}
		
		System.out.println(lista.toString());

		return ;
	}


	
	public static void id_Dos_Produtos_PJ(String cnpj) throws SQLException {
		
		ArrayList<Integer> lista = new ArrayList<>();
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select idProduto_PK from Produto\r\n" + 
					" where idPedido_FK in (select idPedido_PK from Pedido \r\n" + 
					" where idCliente_FK in (select idCliente_PK from Cliente\r\n" + 
					" where idCliente_PK in (select idCliente_SPK from PessoaJuridica\r\n" + 
					" where cnpj = ? )));";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, cnpj);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id = result.getInt(1);
						lista.add(id);
					}
					

					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}
		
		System.out.println(lista.toString());

		return ;
	}
	
	public static void cliente_E_Pedidos_Afetados_Por_Acidente(String acidente) throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select nome, idPedido_PK from Cliente c, Pedido p, Cobre co\r\n" + 
					"where c.idCliente_PK = p.idCliente_FK and p.idPedido_PK = co.idPedido_SPK and co.idAcidente_SPK = ? ;";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, acidente);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						String nome = result.getString(1);
						int id = result.getInt(2);
						System.out.println("[" + nome + ", " + id + "]");
					}
					

					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}
	
	public static void funcionarios_De_Unidade_Motorista_Estoquista_Fora_De_Viagem(String unidade) throws SQLException {
		
		ArrayList<Integer> lista = new ArrayList<>();
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select idFuncionario_PK from Funcionario\r\n" + 
					"where idUnidade_FK = ? and idFuncionario_PK in\r\n" + 
					"(select idFuncionario_SPK from Estoquista\r\n" + 
					"union\r\n" + 
					"select idFuncionario_SPK from Motorista\r\n" + 
					"where emViagem = false);";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, unidade);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id = result.getInt(1);
						lista.add(id);
					}
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
		}
		
		System.out.println(lista.toString());

		return ;
	}
	
	public static void funcionarios_Que_Sao_Clientes() throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select idFuncionario_PK, idCliente_PK\r\n" + 
					"from Funcionario f, PessoaFisica p, Cliente c\r\n" + 
					"where c.idCliente_PK = p.idCliente_SPK and f.RG = p.RG;";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id_Funcionario = result.getInt(1);
						int id_Cliente = result.getInt(2);
						System.out.println("[" + id_Funcionario + ", " + id_Cliente + "]");
					}
					
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}
	
	public static void nome_Seguradoras_Cobrem_Pedidos_A_Partir_De(String data) throws SQLException {
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select nome from Seguradora\r\n" + 
					" where idSeguradora_PK in(select idSeguradora_SPK from Cobre c\r\n" + 
					" where exists(select idPedido_PK from Pedido p\r\n" + 
					" where p.dataSolicitacao > STR_TO_DATE( ? , '%d/%m/%Y') and c.idPedido_SPK = p.idPedido_PK));";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, data);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						String nome = result.getString(1);
						System.out.println("[" + nome + "]");
					}
					
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}
	
	public static void salario_Total_De_Cada_Departamento_Maior_Que(int valor) throws SQLException {
		
		String valorStr = Integer.toString(valor);
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select departamento, concat('R$ ', round(salarioTotal,2)) as salarioTotal\r\n" + 
					"from (select departamento, sum(salario) as salarioTotal from Funcionario\r\n" + 
					"	  group by departamento\r\n" + 
					"	  having salarioTotal > ? ) as SalarioDepartamento;";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, valorStr);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						String nome = result.getString(1);
						String somaValor = result.getString(2);
						System.out.println("[" + nome + ", " + somaValor + "]");
					}
					
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}

	public static void nome_Destinatarios_De_Produtos_De_Um_Container(int id_container) throws SQLException {
		
		String valorStr = Integer.toString(id_container);
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select destinatario from Pedido\r\n" + 
					" where idPedido_PK in (select idPedido_FK from Produto\r\n" + 
					" where idProduto_PK in (select idProduto_FK from Contem\r\n" + 
					" where idContainer_Fk = ? ));  ";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, valorStr);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						String nome = result.getString(1);
						System.out.println("[" + nome + "]");
					}
					
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}
	
	public static void produtos_Despachados_Por_Uma_Unidade_Na_Data(int id_unidade, String data) throws SQLException {
		
		String valorStr = Integer.toString(id_unidade);
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select idProduto_PK from Produto pr, Despacha d, Pedido p\r\n" + 
					"where p.idPedido_PK = d.idPedido_FK and pr.idPedido_FK = p.idPedido_PK and d.idUnidade_FK = ? and d.dataDespacho = "
					+ "STR_TO_DATE( ? , '%d/%m/%Y');";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, valorStr, data);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id_Produto = result.getInt(1);
						System.out.println("[" + id_Produto + "]");
					}
					
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}
	
	public static void estoquista_Que_Estocou_Produto(int id_produto) throws SQLException {
		
		String valorStr = Integer.toString(id_produto);
		
		try(Connection connection = new ConnectionPool().connect()){
			
			int idMaximo;
			
			String sql = "select idFuncionario_SPK from Estoquista et, Estoca e, Container c, Contem ct\r\n" + 
					"where et.idFuncionario_SPK = e.idEstoquista_SPK and ct.idContainer_FK = c.idContainer_PK and c.idContainer_PK = "
					+ "e.idContainer_SPK and ct.idProduto_FK = ? ;";
			
			try(PreparedStatement statement = connection.prepareStatement(sql)){
				
				Insercao.fill_Interrogations_With_Values(statement, valorStr);
				
				statement.execute();
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id_Funcionario = result.getInt(1);
						System.out.println("[" + id_Funcionario + "]");
					}
					
					
					
				}
				
			}	catch (SQLException ex) {
				
				ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
				
			}
			
			
		}

		return ;
	}

}
