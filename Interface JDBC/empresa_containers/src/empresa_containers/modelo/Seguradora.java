package empresa_containers.modelo;

public class Seguradora {
	
	
	private int idSeguradora_PK;
	private String emailSeguradora;
	private String cnpj;
	private String razaoSocial;
	private String nome;
	private String telefone;
	
	
	public int getIdSeguradora_PK() {
		return idSeguradora_PK;
	}
	public void setIdSeguradora_PK(int idSeguradora_PK) {
		this.idSeguradora_PK = idSeguradora_PK;
	}
	public String getEmailSeguradora() {
		return emailSeguradora;
	}
	public void setEmailSeguradora(String emailSeguradora) {
		this.emailSeguradora = emailSeguradora;
	}
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}
	public String getRazaoSocial() {
		return razaoSocial;
	}
	public void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	
	
	public Seguradora(String emailSeguradora, String cnpj, String razaoSocial, String nome, String telefone) {
		super();
		this.emailSeguradora = emailSeguradora;
		this.cnpj = cnpj;
		this.razaoSocial = razaoSocial;
		this.nome = nome;
		this.telefone = telefone;
	}
	
	 @Override
	    public String toString() {
	        return String.format("[seguradora: %d, %s, %s, %s, %s, %s ]", idSeguradora_PK, emailSeguradora, cnpj, razaoSocial, nome, telefone);
	    }	
	
	
	/*
	 *  idSeguradora_PK int(11) PK 
		emailSeguradora varchar(60) 
		cnpj varchar(14) 
		razaoSocial varchar(60) 
		nome varchar(60) 
		telefone varchar(11)
	 */

}
