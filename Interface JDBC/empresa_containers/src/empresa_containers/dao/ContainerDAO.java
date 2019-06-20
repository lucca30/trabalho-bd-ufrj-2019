package empresa_containers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.ExceptionCaller;
import empresa_containers.Insercao;
import empresa_containers.modelo.Container;

public class ContainerDAO {
	
	private Connection conn;

	public ContainerDAO(Connection conn) {
		this.conn = conn;
	}

	public void salva(Container novoContainer) throws SQLException {
		
		int idMaximo;
		
		String sqlMAX_ID = "SELECT MAX(idContainer_PK) FROM Container";
		
		try(Statement statement = conn.createStatement()){
			
			statement.execute(sqlMAX_ID);
			
			try(ResultSet result = statement.getResultSet()){
				
				result.next();
				idMaximo = result.getInt(1);
				
				
			}
			
		}
		
		String sql = "INSERT INTO Container VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, idMaximo+1);
			stmt.setString(2, novoContainer.getDataAquisicao());
			stmt.setDouble(3, novoContainer.getComprimento());
			stmt.setDouble(4, novoContainer.getAltura());
			stmt.setDouble(5, novoContainer.getLargura());
			stmt.setDouble(6, novoContainer.getCapacidade());
			stmt.setString(7, novoContainer.getStatusContainer());
			stmt.setInt(8, novoContainer.getVidaUtil());
			stmt.setInt(9, novoContainer.getLotacaoAtual());
			stmt.setInt(10, novoContainer.getIdLote_FK());
			stmt.setBoolean(11, novoContainer.isDisponibilidade());

			stmt.execute();
			
			System.out.println("Tupla adicionada com sucesso!");
			
		}	catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
	}
	
	public List<Container> lista() throws SQLException {
		
		String sql = "SELECT * FROM Container";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			stmt.execute();
			ResultSet resultSet = stmt.getResultSet();
			ArrayList<Container> containers = new ArrayList<>();
			while(resultSet.next()) {
				String at2 = resultSet.getString(2);
				double at3 = resultSet.getDouble(3);
				double at4 = resultSet.getDouble(4);
				double at5 = resultSet.getDouble(5);
				double at6 = resultSet.getDouble(6);
				String at7 = resultSet.getString(7);
				int at8 = resultSet.getInt(8);
				int at9 = resultSet.getInt(9);
				int at10 = resultSet.getInt(10);
				boolean at11 = resultSet.getBoolean(11);
				int id = resultSet.getInt(1);
				

				Container c = new Container(at2, at3, at4, at5, at6, at7, at8, at9, at10, at11);
				c.setIdContainer_PK(id);
				containers.add(c);
				
			}
			return containers;
		}	catch (SQLException ex) {
			
			ExceptionCaller.sqlString_Exception(ex, "Não foi possível executar o comando SQL desejado. \nErro número ");
			
		}
		
		return null;
	}
	

}
