package empresa_containers.modelo;

public class Container {

	private Integer idContainer_PK;
	private String dataAquisicao;
	private double comprimento;
	private double altura;
	private double largura;
	private double capacidade;

	//public enum StatusContainer {
	//	Em_Uso, Disponivel, Em_Manutenção, Desmobilizado
	//};

	private String statusContainer;
	private int vidaUtil;
	private int lotacaoAtual;
	private int idLote_FK;
	private boolean disponibilidade;

	public String getStatusContainer() {
		return statusContainer;
	}

	public void setStatusContainer(String statusContainer) {
		
		if(statusContainer != "Em_Uso" || statusContainer != "Disponivel" ||
				statusContainer != "Em_Manutenção" || statusContainer != "Desmobilizado" )
			throw new NullPointerException("Esse valor não faz parte do ENUM");
		
		this.statusContainer = statusContainer;
	}

	public Integer getIdContainer_PK() {
		return idContainer_PK;
	}

	public void setIdContainer_PK(Integer idContainer_PK) {
		this.idContainer_PK = idContainer_PK;
	}

	public String getDataAquisicao() {
		return dataAquisicao;
	}

	public void setDataAquisicao(String dataAquisicao) {
		this.dataAquisicao = dataAquisicao;
	}

	public double getComprimento() {
		return comprimento;
	}

	public void setComprimento(double comprimento) {
		this.comprimento = comprimento;
	}

	public double getLargura() {
		return largura;
	}

	public void setLargura(double largura) {
		this.largura = largura;
	}

	public double getCapacidade() {
		return capacidade;
	}

	public void setCapacidade(double capacidade) {
		this.capacidade = capacidade;
	}

	public int getVidaUtil() {
		return vidaUtil;
	}

	public void setVidaUtil(int vidaUtil) {
		this.vidaUtil = vidaUtil;
	}

	public int getLotacaoAtual() {
		return lotacaoAtual;
	}

	public void setLotacaoAtual(int lotacaoAtual) {
		this.lotacaoAtual = lotacaoAtual;
	}

	public int getIdLote_FK() {
		return idLote_FK;
	}

	public void setIdLote_FK(int idLote_FK) {
		this.idLote_FK = idLote_FK;
	}

	public boolean isDisponibilidade() {
		return disponibilidade;
	}

	public void setDisponibilidade(boolean disponibilidade) {
		this.disponibilidade = disponibilidade;
	}
	
	public double getAltura() {
		return altura;
	}

	public void setAltura(double altura) {
		this.altura = altura;
	}

	public Container(String dataAquisicao, double comprimento, double altura, double largura,
			double capacidade, String statusContainer, int vidaUtil, int lotacaoAtual, int idLote_FK,
			boolean disponibilidade) {
		super();

		this.dataAquisicao = dataAquisicao;
		this.comprimento = comprimento;
		this.altura = altura;
		this.largura = largura;
		this.capacidade = capacidade;
		this.statusContainer = statusContainer;
		this.vidaUtil = vidaUtil;
		this.lotacaoAtual = lotacaoAtual;
		this.idLote_FK = idLote_FK;
		this.disponibilidade = disponibilidade;
	}
	
	 @Override
	    public String toString() {
	        return String.format("[produto: %d, %s, %f, %f, %f, %f, %s, %d, %d, %d, %b ]", idContainer_PK, dataAquisicao,
	        		comprimento, altura, largura, capacidade, statusContainer, vidaUtil, lotacaoAtual,
	        		idLote_FK, disponibilidade);
	    }



}
