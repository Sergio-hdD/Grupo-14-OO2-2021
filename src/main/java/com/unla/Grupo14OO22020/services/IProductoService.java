package com.unla.Grupo14OO22020.services;

import java.util.List;

import com.unla.Grupo14OO22020.entities.Producto;
import com.unla.Grupo14OO22020.models.ProductoModel;

public interface IProductoService {

	public abstract List<Producto> getAll();

	public ProductoModel insertOrUpdate(ProductoModel productoModel);

	public ProductoModel findByIdProducto(int id);

	public boolean remove(int id);
}//Fin class
