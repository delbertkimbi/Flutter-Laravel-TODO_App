<?php

namespace App\Http\Controllers;
use App\Models\delbert;
use Request;



class DelbertController extends Controller
{
    public function index(){
        return delbert::all();
    }
    public function store(Request $request){
        $validator = $request->validate([
            'age'=> 'required|numeric',
            'nickname'=> 'required|max:255',
            'preferred_activity'=> 'required',
            'class'=> 'required',
        ]);
         $product= delbert()::create($validator);
         return response()->json($product, 201);
    }
    public function show( Request $delbert){
        
    }
}
