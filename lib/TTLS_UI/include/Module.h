﻿/*
    Copyright 2015-2016 Amebis
    Copyright 2016 GÉANT

    This file is part of GÉANTLink.

    GÉANTLink is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GÉANTLink is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
*/

namespace eap
{
    class peer_ttls_ui;
}

#pragma once

#include "../../TTLS/include/Config.h"
#include "../../TTLS/include/Credentials.h"
#include "../../EAPBase_UI/include/Module.h"


namespace eap
{
    /// \addtogroup EAPBaseModule
    /// @{

    ///
    /// TTLS UI peer
    ///
    class peer_ttls_ui : public peer_ui
    {
    public:
        ///
        /// Constructs a EAP-TTLS UI peer module
        ///
        peer_ttls_ui();

        ///
        /// @copydoc eap::method::make_config_method()
        /// \returns This implementation always returns `eap::config_method_ttls` type of configuration
        ///
        virtual config_method* make_config_method();

        virtual void config_xml2blob(
            _In_  DWORD       dwFlags,
            _In_  IXMLDOMNode *pConfigRoot,
            _Out_ BYTE        **pConnectionDataOut,
            _Out_ DWORD       *pdwConnectionDataOutSize);

        virtual void config_blob2xml(
            _In_                                   DWORD           dwFlags,
            _In_count_(dwConnectionDataSize) const BYTE            *pConnectionData,
            _In_                                   DWORD           dwConnectionDataSize,
            _In_                                   IXMLDOMDocument *pDoc,
            _In_                                   IXMLDOMNode     *pConfigRoot);

        virtual void invoke_config_ui(
            _In_                                     HWND  hwndParent,
            _In_count_(dwConnectionDataInSize) const BYTE  *pConnectionDataIn,
            _In_                                     DWORD dwConnectionDataInSize,
            _Out_                                    BYTE  **ppConnectionDataOut,
            _Out_                                    DWORD *pdwConnectionDataOutSize);

        virtual void invoke_identity_ui(
            _In_                                   HWND   hwndParent,
            _In_                                   DWORD  dwFlags,
            _In_count_(dwConnectionDataSize) const BYTE   *pConnectionData,
            _In_                                   DWORD  dwConnectionDataSize,
            _In_count_(dwUserDataSize)       const BYTE   *pUserData,
            _In_                                   DWORD  dwUserDataSize,
            _Out_                                  BYTE   **ppUserDataOut,
            _Out_                                  DWORD  *pdwUserDataOutSize,
            _Out_                                  LPWSTR *ppwszIdentity);

        virtual void invoke_interactive_ui(
            _In_                                  HWND  hwndParent,
            _In_count_(dwUIContextDataSize) const BYTE  *pUIContextData,
            _In_                                  DWORD dwUIContextDataSize,
            _Inout_                               BYTE  **ppDataFromInteractiveUI,
            _Inout_                               DWORD *pdwDataFromInteractiveUISize);
    };

    /// @}
}
