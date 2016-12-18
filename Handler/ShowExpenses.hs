module Handler.ShowExpenses where

import Import

getShowExpensesR :: Int -> Handler Html
getShowExpensesR int = sendFile "text/html" "static/main.html"

postShowExpensesR :: Int -> Handler Html
postShowExpensesR int = error "Not yet implemented: postShowExpensesR"
