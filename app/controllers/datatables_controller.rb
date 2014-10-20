# https://github.com/rweng/jquery-datatables-rails/issues/41
# https://gist.github.com/ricardodovalle/7244900

class DatatablesController < ApplicationController
  skip_authorization_check

  def datatable_i18n
    if session[:locale] == 'pt' # 'pt-BR'
      locale = {
          'sEmptyTable' =>     'Nenhum dado encontrado na tabela',
          'sInfo' =>           'Mostrando de _START_ ate _END_ de _TOTAL_ registros',
          'sInfoEmpty' =>      'Mostrando de 0 ate 0 de 0 registros',
          'sInfoFiltered' =>   '(filtrado de _MAX_ registros no total)',
          'sInfoPostFix' =>    '',
          'sInfoThousands' =>  ',',
          'sLengthMenu' =>     '_MENU_ registros por pagina',
          'sLoadingRecords' => 'Carregando...',
          'sProcessing' =>     'Processando...',
          'sSearch' =>         'Buscar:',
          'sZeroRecords' =>    'Nenhum dado encontrado',
          'oPaginate' => {
              'sFirst' =>    'Primeiro',
              'sLast' =>     'Ultimo',
              'sNext' =>     'Seguinte',
              'sPrevious' => 'Anterior'
          },
          'oAria' => {
              'sSortAscending' =>  ': ativar ordenacaoo crescente na coluna',
              'sSortDescending' => ': ativar ordenacaoo decrescente na coluna'
          }
      }
    elsif session[:locale] == 'de'
      locale = {
          'sEmptyTable'=>     'Keine Einträge in Tabelle',
          'sInfo'=>           'Zeige _START_ bis _END_ aus _TOTAL_ Einträgen',
          'sInfoEmpty'=>      'Zeige 0 bis 0 aus 0 Einträgen',
          'sInfoFiltered'=>   '(gefiltert aus _MAX_ totalen Einträgen)',
          'sInfoPostFix'=>    '',
          'sInfoThousands'=>  ',',
          'sLengthMenu'=>     '_MENU_ Einträge pro Seite',
          'sLoadingRecords'=> 'Lade...',
          'sProcessing'=>     'Bearbeite...',
          'sSearch'=>         'Suche:',
          'sZeroRecords'=>    'Keine übereinstimmenden Einträge gefunden',
          'oPaginate'=> {
              'sFirst'=>    'Anfang',
              'sLast'=>     'Ende',
              'sNext'=>     'weiter',
              'sPrevious'=> 'zurück'
          },
          'oAria'=> {
              'sSortAscending'=>  ': aktiviere aufsteigende Spaltensortierung',
              'sSortDescending'=> ': aktiviere absteigende Spaltensortierung'
          }
      }
    else
      locale = {
          'sEmptyTable'=>     'No data available in table',
          'sInfo'=>           'Showing _START_ to _END_ of _TOTAL_ entries',
          'sInfoEmpty'=>      'Showing 0 to 0 of 0 entries',
          'sInfoFiltered'=>   '(filtered from _MAX_ total entries)',
          'sInfoPostFix'=>    '',
          'sInfoThousands'=>  ',',
          'sLengthMenu'=>     '_MENU_ records per page',
          'sLoadingRecords'=> 'Loading...',
          'sProcessing'=>     'Processing...',
          'sSearch'=>         'Search:',
          'sZeroRecords'=>    'No matching records found',
          'oPaginate'=> {
              'sFirst'=>    'First',
              'sLast'=>     'Last',
              'sNext'=>     'Next',
              'sPrevious'=> 'Previous'
          },
          'oAria'=> {
              'sSortAscending'=>  ': activate to sort column ascending',
              'sSortDescending'=> ': activate to sort column descending'
          }
      }
    end
    render :json => locale
  end
 
end