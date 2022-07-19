

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.HashMap ;
import java.util.Iterator;
import java.util.LinkedHashMap ;
import java.util.Map ;
import java.util.Set;

import javax.swing.JButton ;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel ;
import javax.swing.JPanel ;

class Dato {
	int x ;
	int y ;
	int r ;
	int g ;
	int b ;

	Dato(int x,int y, int r, int g, int b) {
		this.x= x ;
		this.y= y ;
		this.r= r ;
		this.g= g ;
		this.b= b ;
	}

	Dato(int r, int g, int b){
		this.x=0 ;
		this.y=0 ;
		this.r=r ;
		this.g=g ;
		this.b=b ;
	}

	int getX() {return x ;} 
	int getY() {return y ;} 
	int getR() {return r ;} 
	int getG() {return g ;} 
	int getB() {return b ;}

	public void setX(int d) {
		this.x= d ;
	}

	public void setY(int y) {
		this.y= y ;
	}

	public void setR(int r) {
		this.r= r ;
	}

	public void setG(int g) {
		this.g= g ;
	}

	public void setB(int b) {
		this.b= b ;
	}
}

class Mapa extends JPanel {
	Dato[] datos ;
	Dato[] neuronas ;
	HashMap<Integer,Double> distancias ;
	ArrayList parecidos;
	private int ibmu;
	private int tVecindario;
	private double tG;
	private int iteraciones;
	double dG ;
	double dV ;
	int minV ;
	private Dato d;
	private boolean neuronasFijas;
	public Mapa() {
		super() ;
		neuronasFijas=false ;
		dV=0.9 ;
		minV= 3 ;
		tG=0.05 ;
		dG=1 ;
		distancias= new HashMap<Integer,Double>() ;
		cargarDatos() ;
		parecidos= new ArrayList() ;
		tVecindario= 50 ;

		iteraciones=0 ;
		inicializarNeuronas();
	}
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		g.clearRect(0, 0, getWidth(), getHeight());
		g.setColor(Color.BLUE);
		int r=10 ;
		if (neuronasFijas) {
			r=50;
		}
		if (datos!=null) {
			for(int i=0 ; i<100; i++) {
				g.setColor(new Color(neuronas[i].getR() ,neuronas[i].getG() ,neuronas[i].getB() )) ;
				g.fillOval(neuronas[i].getX(),neuronas[i].getY(),r,r);
			} 
			g.setColor(Color.BLUE);
			g.drawOval(neuronas[ibmu].getX()-4, neuronas[ibmu].getY()-4, r+8, r+8);
			g.setColor(Color.BLACK);

			for (Iterator iterator = parecidos.iterator(); iterator.hasNext();) {
				Dato n= neuronas[(int) iterator.next()] ;
				g.drawOval(n.getX()-2, n.getY()-2, 14, 14);
			}
		}
	}

	public void cargarDatos() {
		datos =  new Dato[100] ; 
		//OJO: datos simulados
		int r=0 ;
		int g=0 ;
		int b=0 ;
		for (int i=0; i<100; i++) {     
			if (Math.random()<0.3) {
				r= (int) (i%50)+200;
				g=200 ;
				b=0;
			} else { 
				r=0 ;
				g=100 ;
				b=(int) (i%50)+200  ;
			}
			datos[i]= new Dato(r,g,b) ;
		}
	}

	public void inicializarNeuronas() {
		neuronas=  new Dato[100] ; 
		for (int i=0; i<100; i++) {
			int x= neuronasFijas?(i/10)*50:((int) (Math.random()*600)) ;
			int y= neuronasFijas?(i%10)*50:((int) (Math.random()*600)) ;     
			int r= ((int) (Math.random()*255)) ;
			int g= ((int) (Math.random()*255)) ;
			int b= ((int) (Math.random()*255)) ;
			neuronas[i]= new Dato(x,y,r,g,b) ;
			distancias.put(i,0.0) ;
		}
	}

	public static HashMap<Integer,Double> sortByValue(HashMap<Integer, Double> hm) { 
		LinkedHashMap<Integer,Double> sortedMap = new LinkedHashMap<>();

		hm.entrySet().stream().sorted(Map.Entry.comparingByValue()).forEachOrdered(x -> sortedMap.put(x.getKey(), x.getValue()));
		return sortedMap; 
	} 


	public void calcularDistanciasyParecidos(int ibmu) {
		this.ibmu= ibmu ;
		int rbmu = neuronas[ibmu].getR();
		int gbmu = neuronas[ibmu].getG();
		int bbmu = neuronas[ibmu].getB();
		for (int i = 0; i < neuronas.length; i++) {
			distancias.put(i, distancia(neuronas[ibmu], neuronas[i]));
		}

		distancias = sortByValue(distancias);
		Set keys = distancias.keySet();
		Iterator iterator = keys.iterator();

		parecidos.clear();
		for (int i = 0; i < tVecindario; i++) {
			Object n = iterator.next();
			parecidos.add(n);
		}

		//tVecindario *= dV;
		
		
	}

	public void acercarParecidos() {

		Dato bmu = neuronas[(int)parecidos.get(0)];
		 
		for (int index = 1; index < parecidos.size(); index++ ){
			Dato neuronaActual = neuronas[(int)parecidos.get(index)];

			neuronaActual.x = (int) (neuronaActual.x + (bmu.x-neuronaActual.x)*tG);
			neuronaActual.y = (int) (neuronaActual.y + (bmu.y-neuronaActual.y)*tG);
			neuronaActual.r = (int) (neuronaActual.r + (bmu.r-neuronaActual.r)*tG);
			neuronaActual.g = (int) (neuronaActual.g + (bmu.g-neuronaActual.g)*tG);
			neuronaActual.b = (int) (neuronaActual.b + (bmu.b-neuronaActual.b)*tG);
		}

		tG *= dG; 
	}

	public int bmu(int i) {
		d = datos[i];
		int ibmu = 0;
		double distancia = distancia(d, neuronas[ibmu]);
		for (int index = 0; index < neuronas.length; index++) {
			double dn = distancia(d, neuronas[index]);
			if (distancia > dn) {
				distancia = dn;
				ibmu = index;
			}
		}
		return ibmu;
	}

	private double distancia(Dato d, Dato n) {
		return Math.pow(d.getR()-n.getR(),2)+Math.pow(d.getG()-n.getG(),2)+Math.pow(d.getB()-n.getB(),2);
	}
}

public class Main extends JFrame {
	Graphics g ;
	JLabel lbl ; 
	JButton btn ;
	JCheckBox chk ;
	JPanel pnl ;
	Mapa m ;
	public Main() {
		m= new Mapa() ;
		setTitle("SOM 2d");
		setBounds(50,50,700,750);
		lbl= new JLabel("Presione el bot�n para iniciar") ;
		lbl.setBounds(10,10,200,50) ;
		add(lbl) ;
		//pnl= new JPanel() ;
		m.setBounds(10,70,620,620) ;
		m.setBackground(Color.WHITE) ;
		add(m) ;
		btn= new JButton("INICIAR") ;
		btn.setBounds(210,10, 150,50) ;
		btn.addActionListener(new ActionListener (){
			public void actionPerformed(ActionEvent arg0) {
				int c=100 ;
				if (chk.isSelected()) {
					c=1 ;
				}
				for (int i = 0; i < c; i++) {
					m.calcularDistanciasyParecidos(m.bmu((int)(Math.random()*100)));
					m.acercarParecidos() ;
					m.repaint() ;	
				}

			}
		});
		add(btn);

		chk= new JCheckBox("ONE STEP") ;
		chk.setSelected(true);
		chk.setBounds(360, 10, 150, 50);
		add(chk) ;
		setLayout(null) ;
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
	}

	public static void main(String args[]) {
		Main t = new  Main();
	}
}