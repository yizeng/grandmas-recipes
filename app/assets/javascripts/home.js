$(document).ready(function() {
  ResetCreateRecipeModal();
  RenderActionButtons();
  HandleCreateRecipe();
  HandleDeleteRecipe();
  HandleViewRecipe();
  HandleEditRecipe();
});

function ResetCreateRecipeModal() {
  $('#form-create-recipe .inputTitle').val('');
  $('#form-create-recipe .inputDescription').val('');
  $('#form-create-recipe .inputIngredients').val('');
  $('#form-create-recipe .inputSteps').val('');
}

function RenderActionButtons() {
  $.ajax({
    url: '/api/recipes',
    dataType: 'json',
    success: function(data) {
      var recipes = data;
      var tbody = '';
      recipes.forEach(function(recipe) {
        var tdRecipeTitle = '<td>' + recipe['title'] + '</td>';
        var recipeId = recipe['id'];
        var btnView = '<button type="button" class="btn btn-primary view-recipe" data-recipe-id="' + recipeId + '">' + 'View</button>';
        var btnEdit = '<button type="button" class="btn btn-secondary edit-recipe" data-recipe-id="' + recipeId + '">' + 'Edit</button>';
        var btnDelete = '<button type="button" class="btn btn-danger delete-recipe" data-recipe-id="' + recipeId + '">' + 'Delete</button>';
        var row = '<tr>' + tdRecipeTitle + '<td class="action-buttons">' + btnView + btnEdit + btnDelete + '</td>' + '</tr>';
        tbody += row;
      });
      $('#my-recipes').append(tbody);
    },
    error: function(e) {
      console.log(e.responseText);
    }
  });
}

function HandleCreateRecipe() {
  $('#form-create-recipe').on('submit', function(e) {
    e.preventDefault();
    var title = $('#form-create-recipe .inputTitle')[0].value;
    var description = $('#form-create-recipe .inputDescription')[0].value;
    var ingredients = $('#form-create-recipe .inputIngredients')[0].value;
    var steps = $('#form-create-recipe .inputSteps')[0].value;
    $.post('/api/recipes', { title, ingredients, steps, description })
      .done(function() {
        alert('New recipe created!');
        $('#create-recipe').modal('toggle');
        setTimeout(function() {
          location.reload();
        }, 1000);
      })
      .fail(function(e) {
        alert('Failed to create a new recipe!\n' + e.responseText);
      });
  });
}

function HandleDeleteRecipe() {
  $(document).on('click', 'button.delete-recipe', function(e) {
    e.preventDefault();
    var id = $(e.currentTarget).attr('data-recipe-id');
    $.ajax({
      method: 'DELETE',
      url: '/api/recipes/' + id
    })
      .done(function() {
        alert('Recipe deleted!');
      })
      .fail(function(e) {
        alert('Failed to delete recipe!\n' + e.responseText);
      })
      .always(function() {
        setTimeout(function() {
          location.reload();
        }, 1000);
      });
  });
}

function HandleViewRecipe() {
  $(document).on('click', 'button.view-recipe', function(e) {
    e.preventDefault();
    var id = $(e.currentTarget).attr('data-recipe-id');
    $.ajax({
      method: 'GET',
      url: '/api/recipes/' + id
    })
      .done(function(data) {
        $('#view-recipe-label').text('View Recipe - ' + data.title);
        $('#view-recipe .inputIngredients').val(data.ingredients);
        $('#view-recipe .inputSteps').val(data.steps);
        $('#view-recipe .inputDescription').val(data.description);
      })
      .fail(function(e) {
        alert('Failed to retrieve recipe!\n' + e.responseText);
      })
      .always(function() {
        $('#view-recipe').modal('toggle');
      });
  });
}

function HandleEditRecipe() {
  // Load values to edit recipe modal.
  var patchUrl = '';
  $(document).on('click', 'button.edit-recipe', function(e) {
    e.preventDefault();

    var id = $(e.currentTarget).attr('data-recipe-id');
    patchUrl = '/api/recipes/' + id;

    $.ajax({
      method: 'GET',
      url: '/api/recipes/' + id
    })
      .done(function(data) {
        $('#edit-recipe-label').text('Edit Recipe - ' + data.title);
        $('#edit-recipe .inputTitle').val(data.title);
        $('#edit-recipe .inputIngredients').val(data.ingredients);
        $('#edit-recipe .inputSteps').val(data.steps);
        $('#edit-recipe .inputDescription').val(data.description);
      })
      .fail(function(e) {
        alert('Failed to retrieve recipe!\n' + e.responseText);
      })
      .always(function() {
        $('#edit-recipe').modal('toggle');
      });
  });

  // Handle form submission.
  $('#form-edit-recipe').on('submit', function(e) {
    e.preventDefault();
    var title = $('#form-edit-recipe .inputTitle')[0].value;
    var description = $('#form-edit-recipe .inputDescription')[0].value;
    var ingredients = $('#form-edit-recipe .inputIngredients')[0].value;
    var steps = $('#form-edit-recipe .inputSteps')[0].value;

    $.ajax({
      method: 'PATCH',
      url: patchUrl,
      data: { title, ingredients, steps, description }
    })
      .done(function() {
        alert('Recipe updated!');
        $('#edit-recipe').modal('toggle');
        setTimeout(function() {
          location.reload();
        }, 1000);
      })
      .fail(function(e) {
        alert('Failed to update recipe!\n' + e.responseText);
      });
  });
}
