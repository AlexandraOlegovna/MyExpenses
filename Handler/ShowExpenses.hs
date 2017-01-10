module Handler.ShowExpenses where

import Import
import Text.Read(read)
-- import Data.Tex  t (unpack)

getShowExpensesR :: Handler ()
getShowExpensesR = do
    maybeLogin <- lookupCookie "login"
    case maybeLogin of
        Nothing -> redirect HomeR
        _ -> sendFile "text/html" "static/main.html"



postShowExpensesR :: Handler Value
postShowExpensesR = do
    (Just login) <- lookupCookie "login"
    (Just (Entity userId _)) <- runDB $ getBy $ UniqueUser login
    usersExpenses <- runDB $ selectList [ExpensesUserId ==. userId] []
    returnJson usersExpenses

postAddR :: Handler Text
postAddR = do
    (Just login) <- lookupCookie "login"
    (Just (Entity userId _)) <- runDB $ getBy $ UniqueUser login
    (Just kind) <- lookupPostParam "kind"
    (Just theme) <- lookupPostParam "theme"
    (Just item) <- lookupPostParam "item"
    (Just cost) <- lookupPostParam "cost"
    (Just date) <- lookupPostParam "date"
    _ <- runDB $ insert $ Expenses userId kind theme item ((read $ unpack cost) :: Int) date
    return "OK"

    -- EXAMPLE:
    -- personId <- insert $ Person "Michael" "Snoyman" 26
    -- maybePerson <- getBy $ PersonName "Michael" "Snoyman"
    -- case maybePerson of
    --     Nothing -> liftIO $ putStrLn "Just kidding, not really there"
    --     Just (Entity personId person) -> liftIO $ print person
