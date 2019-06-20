package empresa_containers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.ExceptionCaller;
import empresa_containers.modelo.Cliente;
import empresa_containers.modelo.Container;

public class ClienteDAO {
	
	private Connection conn;

	public ClienteDAO(Connection conn) {
		this.conn = conn;
	}
	
	public void salva(Cliente novoCliente) throws SQLException {
		
		int idMaximo;
		
		String sqlMAX_ID = "SELECT MAX(idCliente_PK) FROM Cliente";
		
		try(Statement statement = conn.createStatement()){
			
			statement.execute(sqlMAX_ID);
			
			try(ResultSet result = statement.getResultSet()){
				
				result.next();
				idMaximo = result.getInt(1);
				
				
			}
			
		}
		
		String sql = "INSERT INTO Cliente VALUES (?, ?, ?, ?, ?, ?)";

		try (PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, idMaximo+1);
			stmt.setString(2, novoCliente.getCep());
			stmt.setString(3, novoCliente.getEmailCliente());
			stmt.setString(4, novoCliente.getNome());
			stmt.setString(5, novoCliente.getEndereco());
			stmt.setString(6, novoCliente.getTelefone());

			stmt.execute();
			
			System.out.println("Tupla adicionada com sucesso!");
			
			
		}
		
	}
	
	public List<Cliente> lista() throws SQLException {
		String sql = "SELECT * FROM Cliente";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.execute();
			ResultSet resultSet = stmt.getResultSet();
			ArrayList<Cliente> clientes = new ArrayList<>();
			while(resultSet.next()) {
				String at2 = resultSet.getString(2);
				String at3 = resultSet.getString(3);
				String at4 = resultSet.getString(4);
				String at5 = resultSet.getString(5);
				String at6 = resultSet.getString(6);

				int id = resultSet.getInt(1);
				

				Cliente c = new Cliente(at2, at3, at4, at5, at6);
				c.setIdCliente_PK(id);
				clientes.add(c);
			}
			return clientes;
		}		catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
		return null;
	}
	

}
