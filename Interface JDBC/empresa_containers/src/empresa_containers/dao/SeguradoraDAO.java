package empresa_containers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.ExceptionCaller;
import empresa_containers.modelo.Seguradora;

public class SeguradoraDAO {
	
	private Connection conn;

	public SeguradoraDAO(Connection conn) {
		this.conn = conn;
	}
	
	public void salva(Seguradora novaSeguradora) throws SQLException {
		
		int idMaximo;
		
		String sqlMAX_ID = "SELECT MAX(idSeguradora_PK) FROM Seguradora";
		
		try(Statement statement = conn.createStatement()){
			
			statement.execute(sqlMAX_ID);
			
			try(ResultSet result = statement.getResultSet()){
				
				result.next();
				idMaximo = result.getInt(1);
				
				
			}
			
		}
		
		String sql = "INSERT INTO Seguradora VALUES (?, ?, ?, ?, ?, ?)";

		try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			stmt.setInt(1, idMaximo+1);
			stmt.setString(2, novaSeguradora.getEmailSeguradora());
			stmt.setString(3, novaSeguradora.getCnpj());
			stmt.setString(4, novaSeguradora.getRazaoSocial());
			stmt.setString(5, novaSeguradora.getNome());
			stmt.setString(6, novaSeguradora.getTelefone());

			stmt.execute();
			
			System.out.println("Tupla adicionada com sucesso!");
			
			
		}
		
	}
	
	public List<Seguradora> lista() throws SQLException {
		String sql = "SELECT * FROM Cliente";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.execute();
			ResultSet resultSet = stmt.getResultSet();
			ArrayList<Seguradora> seguradoras = new ArrayList<>();
			while(resultSet.next()) {
				String at2 = resultSet.getString(2);
				String at3 = resultSet.getString(3);
				String at4 = resultSet.getString(4);
				String at5 = resultSet.getString(5);
				String at6 = resultSet.getString(6);

				int id = resultSet.getInt(1);
				

				Seguradora s = new Seguradora(at2, at3, at4, at5, at6);
				s.setIdSeguradora_PK(id);;
				seguradoras.add(s);
			}
			return seguradoras;
		}		catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
		return null;
	}

}
