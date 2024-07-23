<?php
namespace App\Http\Controllers;

use Illuminate\Routing\Controller;
use App\Models\Todo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TodoController extends Controller
{
    public function index()
    {
        $todos = Todo::all();
        return response()->json($todos);
    }
    
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'completed' => 'boolean',
        ]);
    
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
    
        try {
            $todo = new Todo();
            $todo->title = $request->title;
            $todo->description = $request->description;
            $todo->completed = $request->completed;
            $todo->save();
    
            return response()->json($todo, 201);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred while saving the todo item.'], 500);
        }
    }
    
    public function update(Request $request, Todo $todo)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'completed' => 'boolean',
        ]);
    
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
    
        try {
            $todo->update($request->only(['title', 'description', 'completed']));
            return response()->json($todo, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred while updating the todo item.'], 500);
        }
    }
    
    public function show(Todo $todo)
    {
        return response()->json($todo);
    }
    
    public function destroy(Todo $todo)
    {
        $todo->delete();
        return response()->json(null, 204);
    }
    
}
