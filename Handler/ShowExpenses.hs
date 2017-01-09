module Handler.ShowExpenses where

import Import

getShowExpensesR :: Handler ()
getShowExpensesR = do
    maybeLogin <- lookupCookie "login"
    case maybeLogin of
        Nothing -> redirect HomeR
        _ -> sendFile "text/html" "static/main.html"



postShowExpensesR :: Handler Text
postShowExpensesR = undefined

    -- do
    -- (Just login) <- lookupCookie "login"
    -- (Just userId) <- runDB $ getBy $ UniqueUser login
    -- usersExpenses <- runDB $ selectList [ExpensesUserId ==. userId] []
    -- return "Ok"
    -- returnJson usersExpenses

    -- EXAMPLE:
    -- personId <- insert $ Person "Michael" "Snoyman" 26
    -- maybePerson <- getBy $ PersonName "Michael" "Snoyman"
    -- case maybePerson of
    --     Nothing -> liftIO $ putStrLn "Just kidding, not really there"
    --     Just (Entity personId person) -> liftIO $ print person
