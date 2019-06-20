package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.dao.ClienteDAO;
import empresa_containers.dao.ContainerDAO;
import empresa_containers.dao.SeguradoraDAO;
import empresa_containers.modelo.Cliente;
import empresa_containers.modelo.Container;
import empresa_containers.modelo.Seguradora;

public class TestaDAOs {

	public static void main(String[] args) throws SQLException {
		
		try(Connection conn = new ConnectionPool().connect()){
			
			/*
			SeguradoraDAO dao = new SeguradoraDAO(conn);
			
			ContainerDAO daoC = new ContainerDAO(conn);
			
			ClienteDAO daoCli = new ClienteDAO(conn);
			
			Seguradora seguradora = new Seguradora("teste@gmail.com", "testecnpj","teste","teste","teste");
			
			Container container = new Container("2019-06-17", 3.0, 3.0, 10.0, 100.0, "Disponivel", 120, 1, 10, true);
			
			Cliente cliente = new Cliente("testecnpj","teste@gmail.com","testehg","teshgte","teshgte");
			
			dao.salva(seguradora);
			
			List<Seguradora> produtos = dao.lista();
			for (Seguradora p : produtos) {
				System.out.println(p);
			}
			
			
			ArrayList<Integer> lista = new ArrayList<>();
			*/
			Consultas.estoquista_Que_Estocou_Produto(1);
			//ConsultasParaUsuario.proc_Insere_Pedido("5558557", "9575572", "13327132813", "Rua do Rosário");
			
			
			// ConsultasParaUsuario.cliente_E_Pedidos_Afetados_Por_Acidente("1");
		
		}

	}
	
}