package com.unla.Grupo14OO22020.repositories;


import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import com.unla.Grupo14OO22020.entities.Producto;



@Repository("productoRepository")
public interface IProductoRepository extends JpaRepository<Producto, Serializable>{
	public abstract Producto findByIdProducto(int id);

}//Fin class
