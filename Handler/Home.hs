module Handler.Home where

import Import
-- import Text.Hamlet (shamlet)
-- import Text.Blaze.Html.Renderer.String (renderHtml)
import Data.Text
import Data.Maybe
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Text.Julius (RawJS (..))
import Text.Hamlet (HtmlUrl, hamlet)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH

-- Define our data that will be used for creating the form.
data FileForm = FileForm
    { fileInfo :: FileInfo
    , fileDescription :: Text
    }

data LogPass = LogPass
    {   login :: Text,
        password :: Text
    }

instance ToJSON LogPass where
    toJSON LogPass {..} = object
        [ "login" .= login
        , "password"  .= password
        ]

instance FromJSON LogPass where
    parseJSON (Object o) = LogPass
        <$> o .: "login"
        <*> o .: "password"
    parseJSON _ = fail "Invalid todo"

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.

-- getHomeR :: Handler Html
getHomeR :: Handler ()
getHomeR = sendFile "text/html" "static/index.html"
-- getHomeR = do
--     (formWidget, formEnctype) <- generateFormPost sampleForm
--
--     let submission = Nothing :: Maybe FileForm
--         handlerName = "getHomeR" :: Text
--
--     defaultLayout $ do
--         let (commentFormId, commentTextareaId, commentListId) = commentIds
--         aDomId <- newIdent
--         setTitle "Welcome To Yesod!"
--         $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR = do
    -- lp <- requireJsonBody :: Handler LogPass -- get the json body as Foo (assumes FromJSON instance)
    -- getParameters <- reqGetParams <$> getRequest
    -- (Just lgValueMaybe) <- lookupPostParam "login"
    -- (Just pasValueMaybe) <- lookupPostParam "password"
    -- userId <- runDB $ insert $ User (lgValueMaybe) (Just pasValueMaybe)
    -- users <- runDB $ selectList [] []
    maybeUser <- runDB $ getBy $ UniqueUser "aaaaaaa"
    case maybeUser of
        Nothing -> defaultLayout [whamlet|<p>No|]
        _ -> defaultLayout [whamlet|<p>Yes|]
    -- defaultLayout $
    --     [whamlet|
    --             $forall Entity userId user <- users
    --                 <h1> #{userIdent user} by #{show (userPassword user)}
    --     |]
    -- userId <- runDB $ insert $ User (lgValueMaybe) (Just pasValueMaybe)
    -- maybeUser <- runDB $ get userId
    -- case maybeUser of
        -- Nothing -> defaultLayout [whamlet|<p>No|]
        -- _ -> defaultLayout [whamlet|<p>Yes|]

    -- ((result, formWidget), formEnctype) <- runFormPost sampleForm
    -- let handlerName = "postHomeR" :: Text
    --     submission = case result of
    --         FormSuccess res -> Just res
    --         _ -> Nothing
    --
    -- defaultLayout $ do
    --     let (commentFormId, commentTextareaId, commentListId) = commentIds
    --     aDomId <- newIdent
    --     setTitle "Welcome To Yesod!"
    --     $(widgetFile "homepage")
--
-- sampleForm :: Form FileForm
-- sampleForm = renderBootstrap3 BootstrapBasicForm $ FileForm
--     <$> fileAFormReq "Choose a file"
--     <*> areq textField textSettings Nothing
--     -- Add attributes like the placeholder and CSS classes.
--     where textSettings = FieldSettings
--             { fsLabel = "What's on the file?"
--             , fsTooltip = Nothing
--             , fsId = Nothing
--             , fsName = Nothing
--             , fsAttrs =
--                 [ ("class", "form-control")
--                 , ("placeholder", "File description")
--                 ]
--             }
--
-- commentIds :: (Text, Text, Text)
-- commentIds = ("js-commentForm", "js-createCommentTextarea", "js-commentList")
