/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Gonzalo
 */
@Entity
@Table(name = "EQUIPO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Equipo.findAll", query = "SELECT e FROM Equipo e")
    , @NamedQuery(name = "Equipo.findByIdequipo", query = "SELECT e FROM Equipo e WHERE e.idequipo = :idequipo")
    , @NamedQuery(name = "Equipo.findByNombre", query = "SELECT e FROM Equipo e WHERE e.nombre = :nombre")
    , @NamedQuery(name = "Equipo.findByEscudo", query = "SELECT e FROM Equipo e WHERE e.escudo = :escudo")})
public class Equipo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "IDEQUIPO")
    private Short idequipo;
    @Column(name = "NOMBRE")
    private String nombre;
    @Column(name = "ESCUDO")
    private String escudo;
    @OneToMany(mappedBy = "local")
    private List<Partido> partidoCollection;
    @OneToMany(mappedBy = "visitante")
    private List<Partido> partidoCollection1;

    public Equipo() {
    }

    public Equipo(Short idequipo) {
        this.idequipo = idequipo;
    }

    public Short getIdequipo() {
        return idequipo;
    }

    public void setIdequipo(Short idequipo) {
        this.idequipo = idequipo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEscudo() {
        return escudo;
    }

    public void setEscudo(String escudo) {
        this.escudo = escudo;
    }

    @XmlTransient
    public List<Partido> getPartidoCollection() {
        return partidoCollection;
    }

    public void setPartidoCollection(List<Partido> partidoCollection) {
        this.partidoCollection = partidoCollection;
    }

    @XmlTransient
    public List<Partido> getPartidoCollection1() {
        return partidoCollection1;
    }

    public void setPartidoCollection1(List<Partido> partidoCollection1) {
        this.partidoCollection1 = partidoCollection1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idequipo != null ? idequipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Equipo)) {
            return false;
        }
        Equipo other = (Equipo) object;
        if ((this.idequipo == null && other.idequipo != null) || (this.idequipo != null && !this.idequipo.equals(other.idequipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Equipo[ idequipo=" + idequipo + " ]";
    }
    
}
