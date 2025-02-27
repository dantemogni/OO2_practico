package com.unla.tp.services.implementation;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unla.tp.entities.Aula;
import com.unla.tp.entities.Espacio;
import com.unla.tp.entities.Laboratorio;
import com.unla.tp.entities.Tradicional;
import com.unla.tp.respositories.AulaRepository;
import com.unla.tp.respositories.EspacioRepository;
import com.unla.tp.services.IEspacioService;
import com.unla.tp.utils.Funciones;

@Service
public class EspacioServiceImpl implements IEspacioService {
    @Autowired
    private EspacioRepository espacioRepository;

    @Autowired
    private AulaRepository aulaRepository;

    public Espacio traer(LocalDate fecha, char turno, Aula aula) {
        List<Espacio> lista = espacioRepository.findAllByAula(aula);
        Espacio espacioATraer = null;
        for (Espacio e : lista) {
            if (e.getFecha().equals(fecha) && e.getTurno() == turno) {
                espacioATraer = e;
            }
        }

        return espacioATraer;
    }

    @Override
    public void agregar(LocalDate fecha, char turno, Aula aula, boolean libre) throws Exception {
        Espacio e = traer(fecha, turno, aula);

        if (e != null) {
            throw new Exception("ERROR. Ya existe un espacio con estos datos");
        }

        Espacio space = new Espacio();

        space.setAula(aula);
        space.setFecha(fecha);
        space.setLibre(libre);
        space.setTurno(turno);

        espacioRepository.save(space);
    }

    // Le muestra al administrador todas aquellas aulas que pueden usarse
    @Override
    public List<Espacio> matchedSpaces(LocalDate fecha, char turno, int cantAlumnos) {
        List<Espacio> spaces = espacioRepository.findAll();
        List<Espacio> matchedSpaces = new ArrayList<>();
        int bancos = 0; // Sillas disponibles

        for (Espacio s : spaces) {
            if (s.getAula() instanceof Tradicional) {
                Tradicional trad = (Tradicional) s.getAula();
                bancos = trad.getCantBancos();
            } else {
                Laboratorio lab = (Laboratorio) s.getAula();
                bancos = lab.getCantSillas();
            }

            // Si está disponible, el turno pedido coincide y hay sufientes bancos...
            if (s.isLibre() && s.getTurno() == turno && bancos >= cantAlumnos && s.getFecha().equals(fecha)) {
                matchedSpaces.add(s);
            }
        }

        return matchedSpaces;
    }

    @Override
    public void agregarEspacioMes(int mes, int anio, char turno, Aula aula) throws Exception {
        for (int i = 1; i <= Funciones.traerCantDiasDeUnMes(anio, mes); i++) {
            // System.out.println("INSERT INTO `espacio` (fecha, libre, turno, aula_id)
            // VALUES ('"
            // + LocalDate.of(anio, mes, i) + "', 1, '" + turno + "', " + aula.getId() +
            // ");");
            agregar(LocalDate.of(anio, mes, i), turno, aula, true);
        }
    }

    @Override
    public void inicializarEspacios(int mes, int anio) throws Exception {
        // Genera todos los espacios para usarlos luego
        List<Aula> aulas = aulaRepository.findAll();
        for (Aula a : aulas) {
            agregarEspacioMes(mes, anio, 'M', a); // mañana
            agregarEspacioMes(mes, anio, 'T', a); // tarde
            agregarEspacioMes(mes, anio, 'N', a); // noche
        }
    }

    @Override
    public void eliminar(Espacio espacio) {
        espacioRepository.delete(espacio);
    }

    @Override
    public List<Espacio> getAll() {
        return espacioRepository.findAll();
    }

    @Override
    public Espacio getById(int id) {
        return espacioRepository.getById(id);
    }

    @Override
    public void updateStatus(int id, boolean libre) {
        Espacio e = espacioRepository.getById(id);
        e.setLibre(libre);
        espacioRepository.save(e);
    }

}
