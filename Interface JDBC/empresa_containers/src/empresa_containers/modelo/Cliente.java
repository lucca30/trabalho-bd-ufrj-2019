package empresa_containers.modelo;

public class Cliente {
	
	
	private int idCliente_PK;
	String cep;
	String emailCliente;
	String nome;
	String endereco;
	String telefone;
	
	
	public Cliente(String cep, String emailCliente, String nome, String endereco, String telefone) {
		super();
		this.cep = cep;
		this.emailCliente = emailCliente;
		this.nome = nome;
		this.endereco = endereco;
		this.telefone = telefone;
	}
	

	public int getIdCliente_PK() {
		return idCliente_PK;
	}
	public void setIdCliente_PK(int idCliente_PK) {
		this.idCliente_PK = idCliente_PK;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String getEmailCliente() {
		return emailCliente;
	}
	public void setEmailCliente(String emailCliente) {
		this.emailCliente = emailCliente;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	
	 @Override
	    public String toString() {
	        return String.format("[cliente: %d, %s, %s, %s, %s, %s ]", idCliente_PK, cep, emailCliente, nome, endereco, telefone);
	    }


}
